require "git"

module Merged
  class ChangesController < MergedController

    def index
      @git = Git.open(Rails.root)
      @status = @git.status()
    end

    def commit
      raise "must have message" if params[:message].blank?
      git = Git.open(Rails.root)
      git.add("cms")
      git.add("app/assets/images/cms")
      begin
        git.commit(params[:message])
      rescue
      end
      redirect_to changes_index_url
    end
  end
end
