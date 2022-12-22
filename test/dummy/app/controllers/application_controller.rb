class ApplicationController < ActionController::Base
  def authenticate_member!
    true
  end
  def current_member
    Member.new(email: "torsten@villataika.fi")
  end
end
