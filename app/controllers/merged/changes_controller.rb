require "git"

module Merged
  class ChangesController < MergedController

    def index
      @git = Git.open(Rails.root)
      @status = @git.status()
    end

    def commit
      if params[:message].blank?
        message = "must have message"
        redirect_to changes_index_url , alert: message
      else
        git = Git.open(Rails.root)
        git.add("merged")
        git.add( Image.root )
        begin
          g.config('user.email', current_member.email)
          git.commit(params[:message])
          redirect_to changes_index_url , notice: "Changes commited"
        rescue
          redirect_to changes_index_url , notice: "Error occurred"
        end
      end
    end

    def reset
      git = Git.open(Rails.root)
      begin
        git.checkout_file("HEAD" , "merged")
        ChangeSet.current.zero
        message = "Changes reset"
      rescue
        message = "Unknown error occured"
      end
      redirect_to changes_index_url , notice: message
    end

  end
end
