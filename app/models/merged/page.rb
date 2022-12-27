module Merged
  class Page < ViewBase

    fields :name , :type , :options, :redirects

    alias :template :type

    def change_name
      self.name
    end

    def add_redirect
      olds = self.redirects.to_s.split(" ")
      olds << self.name unless olds.include?(self.name)
      self.redirects = olds.join(" ")
    end

    def sections
      Section.where(page_id: id).order(index: :asc)
    end

    def sections_update
      last_update_for( sections )
    end

    def template_style
      PageStyle.find_by_type( type )
    end

    def new_section(section_template = nil)
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

    def delete
      sections.each {|section| section.delete }
      delete_save!
    end

    def save(editor)
      olds = self.redirects.to_s.split(" ")
      olds.delete( self.name.to_s )
      self.redirects = olds.join(" ")
      super
    end

    def self.new_page(name , type)
      data = { name: name.dup , updated_at: Time.now , type: type}
      Page.new(data)
    end

  end
end
