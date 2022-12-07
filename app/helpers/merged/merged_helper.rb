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
    def submit_button(text , danger = false )
      clazz = "bg-blue-500 " #full names, no tricks for tailwind
      clazz = "bg-red-500 " if danger
      clazz += button_classes
      content_tag(:button , class: clazz , type: :submit) do
        text
      end
    end
    def button_classes
      "mr-3 inline-block rounded-lg px-4 py-3 text-md font-medium text-white"
    end
  end
end
