module Merged
  class MergedController < ::ApplicationController
    before_action :authenticate_member!
    layout "merged/application"
  end
end
