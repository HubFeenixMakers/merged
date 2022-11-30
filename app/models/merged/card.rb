module Merged
  class Card
    include ActiveModel::API
    include ActiveModel::Conversion
    extend  ActiveModel::Naming

    cattr_reader :all
    @@all = {}

    attr_reader  :content  , :section

    def initialize(section , card_data)
      @section = section
      raise "No data #{card_data}" unless card_data.is_a?(Hash)
      @content = card_data
      raise "No id #{card_data}" unless id.is_a?(String)
      @@all[self.id] = self
    end

    def id
      @content['id']
    end
  end
end
