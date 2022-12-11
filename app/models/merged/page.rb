module Merged
  class Page < ActiveYaml::Base
    set_root_path Rails.root #ouside engines not necessary

    # could be config options
    def self.cms_root
      "cms"
    end

    fields :name , :content , :size , :updated_at

    alias :id  :name

    def sections
      Section.where(page_id: name).order(index: :asc)
    end

    def self.check_name(name)
      return "only alphanumeric, not #{name}" if name.match(/\A[a-zA-Z0-9]*\z/).nil?
      nil
    end
    def self.build_new(name)
      raise "only alphanumeric, not #{name}" unless check_name(name).nil?
      name = name + ".yaml"
      fullname = Rails.root.join(Page.cms_root , name )
      File.write(fullname , "--- []\n")
      Page.new(name)
    end

    def self.destroy( page )
      @@all.delete(page.name)
      File.delete(Rails.root.join(Page.cms_root , page.name + ".yaml"))
    end

    def new_section(section_template)
      section_template = "section_spacer" if section_template.blank?
      section_data = Section.build_data(section_template)
      index = sections.length
      section = Section.new(self , index,  section_data)
      @sections << section
      @content << section_data
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

    def save
      super
      data = Page.all.collect {|obj| obj.attributes}
      File.write( Page.full_path , data.to_yaml)
    end

  end
end
