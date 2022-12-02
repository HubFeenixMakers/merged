module Merged
  module MergedHelper
    def blue_button( text, url)
      button( text , url , "bg-blue-500" )
    end
    def yellow_button( text, url)
      button( text , url , "bg-yellow-500" )
    end
    def red_button( text, url)
      button( text , url , "bg-red-500" )
    end
    def green_button( text, url)
      button( text , url , "bg-green-500" )
    end


    def button(text , url , color)
      claz = color + " ml-3 inline-block rounded-lg px-4 py-3 text-md font-medium text-white"
      link_to(url) do
        content_tag(:button , class: claz ) do
          text
        end
      end
    end
  end
end
