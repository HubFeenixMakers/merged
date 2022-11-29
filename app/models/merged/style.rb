module Merged
  class Style
    include ActiveModel::API


    attr_reader :content

    def initialize content
      @content = content
    end

    def template
      @content["template"]
    end
    def header
      @content["header"]
    end
    def text
      @content["text"]
    end
    def cards
      @content["cards"] == true
    end
    def preview
      "merged/section_preview/" + template
    end

    def self.all
      # should account for app styles. now just loading engines
      @@styles = YAML.load_file(Engine.root.join("config/styles.yaml"))
      @@styles.collect{ |content| Style.new(content) }
    end

  end
end
