class Member
  attr_reader :email
  def initialize(hash)
    @email = hash[:email]
  end
end
