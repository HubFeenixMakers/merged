module Merged
  module ChangesHelper

    def cms_part? name
      return true if name.include?( Image.root )
      return true if name.include?("merged/")
      false
    end
  end
end
