module Merged
  class Page < ViewBase

    fields :name , :type , :options, :redirects

    alias :template :type

    def add_redirect
      olds = self.redirects.to_s.split(" ")
      olds << self.name unless olds.include?(self.name)
      self.redirects = olds.join(" ")
    end

    def sections
      Section.where(page_id: id).order(index: :asc)
    end

    def section_update
      last = Time.now
      last_section = nil
      sections.each do |section|
        if( section.updated_at < last )
          last = section.updated_at
          last_section = section
        end
      end
      last_section
    end

    def template_style
      PageStyle.find_by_type( type )
    end

    def new_section(section_template)
      section_template = "section_spacer" if section_template.blank?
      section = Section.new_section(section_template, self.id , sections.length + 1)
      section
    end

    def remove_section(section)
      from_index = section.index
      @sections.delete_at(from_index)
      @content.delete_at(from_index)
      @sections.each_with_index do |section, index|
        section.set_index(index)
      end
    end

    def first_template
      return "none" unless @content[0]
      @content[0]["template"]
    end

    def reset_index
      sections.each_with_index{|section, index| section.index = index + 1}
    end

    def destroy
      has_sections , has_cards = delete()
      Page.save_all
      if has_sections > 0
        Section.save_all
        Card.save_all if has_cards > 0
      end
    end

    def delete
      has_sections = sections.length
      has_cards = 0
      sections.each {|section| has_cards += section.delete(false) }
      super
      [has_sections , has_cards]
    end

    def save(editor)
      olds = self.redirects.to_s.split(" ")
      olds.delete( self.name.to_s )
      self.redirects = olds.join(" ")
      super
    end

    def self.new_page(name )
      raise "only alphanumeric, not #{name}" unless check_name(name).nil?
      data = { name: name.dup , updated_at: Time.now }
      Page.new(data)
    end

    def self.check_name(name)
      return "only alphanumeric, not #{name}" if name.match(/\A[a-zA-Z0-9]*\z/).nil?
      nil
    end

  end
end
