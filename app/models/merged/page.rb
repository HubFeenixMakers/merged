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

    attr_reader :name , :content , :sections , :size , :updated_at

    alias :id  :name

    def initialize( f_name )
      @name = f_name.split(".").first
      @content = YAML.load_file( filename )
      @sections = []
      @content.each_with_index do |section_data, index|
        section = Section.new(self , index,  section_data)
        @sections << section
      end
      @@all[@name] = self
      update_size
    end

    def filename
      Rails.root.join(Page.cms_root , @name + ".yaml")
    end
    def update_size
      @size = File.size(filename)
      @updated_at = File.ctime(filename)
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

    def move_section_up(section)
      return if sections.length == 1
      return if section.index == 0
      swap_sections( section , sections[section.index - 1])
    end

    def move_section_down(section)
      return if sections.length == 1
      return if section.index == sections.last.index
      swap_sections( section , sections[section.index + 1])
    end

    def swap_sections( this_section , that_section)
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
      File.write( filename , @content.to_yaml)
      update_size
    end

    def self.find(name)
      raise "nil given" if name.blank?
      page = @@all[name]
      raise "Page not found #{name}" unless page
      return page
    end

  end
end
