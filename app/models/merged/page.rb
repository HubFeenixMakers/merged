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

    def new_section
      section = Hash.new
      section['id'] = SecureRandom.hex(10)
      @content << section
      Section.new(self , 0 , section)
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
