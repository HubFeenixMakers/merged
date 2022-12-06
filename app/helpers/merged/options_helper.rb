module Merged
  module OptionsHelper

    # use options with as many option names as neccessary
    def options(section, *args )
      all = {}
      args.each do |option_name|
        hash = send "#{option_name}_option".to_sym , section
        all.merge!(hash) { |key, one, two| one.to_s + " " + two.to_s }
      end
      all
    end

    def order_option(section , clazz = "")
      if section.has_option?("order")
        option = section.option('order')
        puts "Order #{option}"
        clazz += " order-last" if option == "right"
      end
      {class: clazz}
    end

    def align_option(section)
      return {} unless section.has_option?("align")
      option = section.option('align')
      puts "align #{option}"
      # text-center , text-left , text-right , leave comment for tailwind
      {class: "text-#{option}"}
    end

    def background_option(section)
      return {} unless section.has_option?("background")
      option = section.option('background')
      puts "Background #{option}"
      background = bg_for(option)
      background += " text-white" if option.include?("solid")
      {class: background}
    end

    def margin_option(section)
      return {} unless section.has_option?("margin")
      option = section.option('margin')
      puts "Margin #{option}"
      {class: margin_for(option)}
    end

    def color_option(section)
      return {} unless section.has_option?("color")
      option = section.option('color')
      puts "Text color #{option} , #{color_for(option)}"
      {class: color_for(option) }
    end

    def shade_option(section)
      return {} unless section.has_option?("shade_color")
      option = section.option('shade_color')
      puts "Shade color #{option} , #{shade_for(option)}"
      {class: shade_for(option) }
    end

    def column_option(section)
      option = section.option('columns')
      option = 2 if option.blank?
      puts "Columns #{option}"
      case option
      when "3"
        columns = "grid-cols-1 md:grid-cols-2 lg:grid-cols-3"
      when "4"
        columns = "grid-cols-1 md:grid-cols-2 lg:grid-cols-4"
      else # two
        columns = "grid-cols-1 md:grid-cols-2"
      end
      {class: columns }
    end

    private
    # need full color names for tailwind to pick it up
    def bg_for( option )
      { "white" =>  "bg-white" ,
        "none" =>  "" ,
        "light_blue" => "bg-cyan-100" ,
        "light_gray" => "bg-gray-100" ,
        "light_orange" => "bg-orange-50" ,
        "solid_blue" => "bg-cyan-700" ,
        "solid_red" => "bg-orange-800" ,
        "solid_green" => "bg-green-700" ,
        "solid_petrol" => "bg-teal-700" ,
        "solid_indigo" => "bg-indigo-800" ,
        "solid_black" => "bg-slate-900" ,
      }[option] || ""
    end
    # need full margin names for tailwind to pick it up
    def margin_for( option )
      { "0" =>  "m-0" ,
        "none" =>  "" ,
        "20" => "m-20" ,
      }[option] || ""
    end
    # need full color names for tailwind to pick it up
    def color_for( option )
      { "white" => "text-white",
        "none" => "",
        "light_blue" => "text-cyan-100" ,
        "solid_blue" => "text-cyan-700" ,
        "solid_red" => "text-orange-800" ,
        "solid_green" => "text-green-700" ,
        "solid_petrol" => "text-teal-700" ,
        "solid_indigo" => "text-indigo-800" ,
        "solid_black" => "text-slate-900" ,
      }[option] || ""
    end
    # need full color names for tailwind to pick it up

    def shade_for( option )
      { "white_25" => "bg-white/25",
        "none" => "",
        "black_25" => "bg-black/25" ,
        "light_blue_25" => "bg-cyan-100/25" ,
        "light_red_25" => "bg-orange-300/25" ,
        "solid_blue_25" => "bg-cyan-700/25" ,
        "solid_red_25" => "bg-orange-800/25" ,
      }[option] || ""
    end
  end
end
