module Merged

  class Card < ViewBase

    belongs_to :section , class_name: "Merged::Section"

    fields  :id , :index , :section_id
    fields  :text , :header, :image_name

    def move_up
      swap_index_with(next_card)
    end

    def move_down
      swap_index_with(previous_card)
    end

    def previous_card
      section.cards.where(index: index - 1).first
    end

    def next_card
      section.cards.where(index: index + 1).first
    end

    # card templates are stored in the section so the all cards
    # have the same
    def template
      section.card_template
    end

    def template_style
      CardStyle.find_by_template( self.template )
    end

    def destroy
      delete
      Card.save_all
    end

    def delete(reindex = true)
      Card.delete( self.id )
      section.reset_index if reindex
    end

    def save
      super
      Card.save_all
    end

    def self.save_all
      data = Card.the_private_records.collect {|obj| obj.attributes}
      File.write( Card.full_path , data.to_yaml)
      Card.reload
    end

    def self.new_card(card_template , section_id , index)
      data = { section_id: section_id , index: index}
      template = CardStyle.find_by_template( card_template )
      template.fields.each do |key|
        data[key] = "NEW"
      end
      card = Card.new(data)
      card.add_default_options(template.options_definitions)
      card
    end

  end
end
