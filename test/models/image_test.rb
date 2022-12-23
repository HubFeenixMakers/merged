require "test_helper"

module Merged
  class ImageTest < ActiveSupport::TestCase

    def first
      Image.first
    end

    def test_has_all
      assert_equal Image.all.length ,  17
    end
    def test_has_image
      assert_equal first.class ,  Image
    end
    def test_has_name
      assert_equal first.name ,  "Common spaces"
    end
    def test_has_height_and_width
      assert_equal first.height ,  300
      assert_equal first.width ,  560
    end
    def test_aspect
      assert_equal first.aspect_ratio ,  [13,7]
    end

  end
end
