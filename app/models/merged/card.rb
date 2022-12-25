module Merged

  class Card < ViewBase

    belongs_to :section , class_name: "Merged::Section"

    fields  :id , :index , :section_id
    fields  :text , :header, :image_name

    def move_up
      swap_index_with(next_card)
    end

    def change_name
      pagename = section ? section.page.name : section_id.to_s
      "#{pagename}:#{header}"
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

    def delete(reindex = true)
      super()
      section.reset_index if reindex
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
