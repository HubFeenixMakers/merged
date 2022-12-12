module Merged
  class Section < ActiveYaml::Base
    set_root_path Rails.root #ouside engines not necessary

    include ActiveHash::Associations
    belongs_to :page , class_name: "Merged::Page"

    include Optioned

    fields :name , :page_id , :index , :options
    fields :template , :card_template , :id , :text , :header, :image

    def cards
      Card.where(section_id: id).order(index: :asc)
    end

    def set_template(new_template)
      self.template = new_template
      new_style = template_style
      if(new_style.has_cards?)
        unless card_template
          self.card_template = CardStyle.first.template
        end
      end
    end

    def template_style
      SectionStyle.find_by_template( template )
    end

    def has_cards?
      ! card_template.blank?
    end

    def remove_card(card)
      from_index = card.index
      @cards.delete_at(from_index)
      @content["cards"].delete_at(from_index)
      @cards.each_with_index do |card, index|
        card.set_index(index)
      end
    end

    def move_up
      swap_index_with(next_section)
    end

    def move_down
      swap_index_with(previous_section)
    end

    def previous_section
      page.sections.where(index: index - 1).first
    end

    def next_section
      page.sections.where(index: index + 1).first
    end

    def new_card
      card = Card.new_card(card_template, self.id , cards.length + 1)
      card
    end

    def reset_index
      cards.each_with_index{|card, index| card.index = index + 1}
    end

    def destroy
      has_cards = delete()
      Section.save_all
      Card.save_all if has_cards > 0
    end

    def delete( reindex = true )
      has_cards = cards.length
      cards.each {|card| card.delete(false) }
      Section.delete( self.id )
      page.reset_index if reindex
      has_cards
    end

    def save
      super
      Section.save_all
    end

    def self.new_section(template , page_id , index)
      data = { template: template , index: index , page_id: page_id}
      style = SectionStyle.find_by_template( template)
      style.fields.each do |key|
        data[key] = key.upcase
      end unless style.fields.blank?
      if(style.has_cards?)
        data["cards"] = []
        data["card_template"] = CardStyle.first.name
      end
      s = Section.new(data)
      s.add_default_options
      s
    end

    def self.save_all
      data = Section.the_private_records.collect {|obj| obj.attributes}
      File.write( Section.full_path , data.to_yaml)
      Section.reload
    end

  end
end
