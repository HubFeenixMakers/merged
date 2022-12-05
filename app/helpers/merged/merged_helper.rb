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

    def order_option(section)
      return {} unless section.has_option?("order")
      option = section.option('order')
      puts "Order #{option}"
      return {} if option == "right"
      {class: "order-last"}
    end

    def background_option(section)
      return {} unless section.has_option?("background")
      option = section.option('background')
      puts "Background #{option}"
      return {} if option == "white"
      case option
      when "blue"
        background = "bg-cyan-100"
      else
        background = "white"
      end
      {class: background}
    end

    def column_option(section)
      option = section.option('columns')
      option = 2 if option.blank?
      puts "Columns #{option}"
      case option
      when "3"
        columns = "grid-cols-1 md:grid-cols-3"
      when "4"
        columns = "grid-cols-1 md:grid-cols-2 lg:grid-cols-4"
      else # two
        columns = "grid-cols-1 md:grid-cols-2"
      end
      {class: columns}

    end
    def button(text , url , color)
      link_to(url) do
        content_tag(:button , class: color + " " + button_classes ) do
          text
        end
      end
    end
    def button_classes
      "ml-3 inline-block rounded-lg px-4 py-3 text-md font-medium text-white"
    end
  end
end
