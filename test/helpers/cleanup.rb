require "git"

module Merged
  module Cleanup
    def teardown
      git = Git.open(Engine.root)
      git.checkout_file("HEAD" , "test/dummy/merged")
      [Page, Section, Card].each { |m| m.reload(true) }
    end
  end
end
