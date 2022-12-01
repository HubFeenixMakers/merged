module Merged
  class Page
    include ActiveModel::API
    include ActiveModel::Conversion
    extend  ActiveModel::Naming

    # could be config options
    def self.cms_root
      "cms"
    end

    cattr_reader :all
    @@all = {}

    def self.load_pages()
      files = Set.new Dir.new(Rails.root.join(Page.cms_root)).children
      files.each do |file|
        page = Page.new(file)
      end
    end

    attr_reader :name , :content , :sections

    alias :id  :name

    def initialize( file_name )
      @name = file_name.split(".").first
      @content = YAML.load_file(Rails.root.join(Page.cms_root , file_name))
      @sections = []
      @content.each_with_index do |section_data, index|
        section = Section.new(self , index,  section_data)
        @sections << section
      end
      @@all[@name] = self
    end

    def first_template
      @content[0]["template"]
    end

    def move_section_up(section)
      return if sections.length == 1
      return if section.index == 0
      swap( section , sections[section.index - 1])
    end

    def move_section_down(section)
      return if sections.length == 1
      return if section.index == sections.last.index
      swap( section , sections[section.index + 1])
    end

    def swap( this_section , that_section)
      # swap in the actual objects, index is cached in the objects
      this_old_index = this_section.index
      this_section.set_index( that_section.index )
      that_section.set_index( this_old_index )

      # swap in the sections cache
      sections[ this_section.index ] = this_section
      sections[ that_section.index ] = that_section
      # swap in the yaml
      content[this_section.index] = this_section.content
      content[that_section.index] = that_section.content
    end

    def save
      file_name = Rails.root.join(Page.cms_root , name + ".yaml")
      File.write( file_name , @content.to_yaml)
    end

    def self.find(name)
      raise "nil given" if name.blank?
      page = @@all[name]
      raise "Page not found #{name}" unless page
      return page
    end

  end
end
