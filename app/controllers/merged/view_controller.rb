module Merged
  class ViewController < ::ApplicationController

    def view
      page = params[:id]
      # assert file exists
      @data = YAML.load_file(Rails.root.join('cms' , "#{page}.yaml"))
      #assert data is an array (of hashes?)
    end

  end
end
