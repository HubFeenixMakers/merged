module Merged
  class Page
    include ActiveModel::API
    include ActiveModel::Conversion
    extend  ActiveModel::Naming

    @@root = "cms"
    @@files = Set.new Dir.new(Rails.root.join(@@root)).children

    attr_reader :name , :content

    alias :id  :name

    def persisted?
      false
    end

    def initialize file_name
      @name = file_name.split(".").first
      @content = YAML.load_file(Rails.root.join(@@root , file_name))
    end

    def sections
      sections = []
      @content.each_with_index do |section_data, index|
        sections << Section.new(self , index,  section_data)
      end
      sections
    end

    def find_section(section_id)
      @content.each_with_index do |section , index|
        next unless section["id"] == section_id
        return Section.new(self , index , section)
      end
      raise "Page #{name} as no section #{section_id}"
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
      file_name = Rails.root.join(@root , name + ".yaml")
      File.write( file_name , @content.to_yaml)
    end

    def self.all
      @@files.collect{ |file| Page.new(file) }
    end

    def self.find(name)
      Page.new(name + ".yaml")
    end

  end
end
