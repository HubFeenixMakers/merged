module Merged
  class Section < ViewBase

    belongs_to :page , class_name: "Merged::Page"

    fields :id , :page_id , :index
    fields :template , :card_template
    fields :header, :text , :image_name

    def change_name
      "#{page.name}:#{header}"
    end

    def cards
      Card.where(section_id: id).order(index: :asc)
    end

    def cards_update
      last_update_for( cards )
    end

    def template_style
      SectionStyle.find_by_template( template )
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

    def has_cards?
      ! card_template.blank?
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

    def delete(editor)
      cards.each {|card| card.delete_save!(editor) }
      delete_save!(editor)
    end

    def delete_and_reset_index(editor)
      delete(editor)
      Page.find(page_id).reset_index
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

  end
end
