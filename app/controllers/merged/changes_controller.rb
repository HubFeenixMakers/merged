require "rugged"

module Merged
  class ChangesController < MergedController

    def index
      @git = Rugged::Repository.new(Rails.root)
    end

  end
end
