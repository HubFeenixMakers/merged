module Merged
  class MergedController < ApplicationController
    before_action :authenticate_member!
  end
end
