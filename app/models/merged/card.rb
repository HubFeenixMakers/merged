module Merged
  class Card
    include ActiveModel::API
    include ActiveModel::Conversion
    extend  ActiveModel::Naming

    attr_reader  :content  , :section

    def initialize(section , card_data)
      @section = section
      raise "No data #{card_data}" unless card_data.is_a?(Hash)
      @content = card_data
    end

  end
end
