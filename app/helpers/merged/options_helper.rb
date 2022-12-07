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
        clazz += " order-last" if section.option('order') == "right"
      end
      {class: clazz}
    end

    def align_option(section , clazz = "")
      if section.has_option?("align")
        # text-center , text-left , text-right , leave comment for tailwind
        clazz += " text-#{section.option('align')}"
      end
      {class: clazz}
    end

    def background_option(section , clazz = "")
      if section.has_option?("background")
        option = section.option('background')
        clazz += bg_for(option)
        clazz += " text-white" if option.include?("solid")
      end
      {class: clazz}
    end

    def margin_option(section , clazz = "")
      if section.has_option?("margin")
        clazz += margin_for(section.option("margin"))
      end
      {class: clazz}
    end

    def color_option(section , clazz = "")
      if section.has_option?("color")
        clazz += color_for(section.option("color"))
      end
      {class: clazz }
    end

    def shade_option(section)
      if section.has_option?("shade_color")
        clazz += shade_for(section.option("shade_color"))
      end
      {class: clazz }
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
      { "white" =>  " bg-white" ,
        "none" =>  "" ,
        "light_blue" => " bg-cyan-100" ,
        "light_gray" => " bg-gray-100" ,
        "light_orange" => " bg-orange-50" ,
        "solid_blue" => " bg-cyan-700" ,
        "solid_red" => " bg-orange-800" ,
        "solid_green" => " bg-green-700" ,
        "solid_petrol" => " bg-teal-700" ,
        "solid_indigo" => " bg-indigo-800" ,
        "solid_black" => " bg-slate-900" ,
      }[option] || ""
    end
    # need full margin names for tailwind to pick it up
    def margin_for( option )
      { "0" =>  " m-0" ,
        "none" =>  "" ,
        "20" => " m-20" ,
      }[option] || ""
    end
    # need full color names for tailwind to pick it up
    def color_for( option )
      { "white" => " text-white",
        "none" => "",
        "light_blue" => " text-cyan-100" ,
        "solid_blue" => " text-cyan-700" ,
        "solid_red" => " text-orange-800" ,
        "solid_green" => " text-green-700" ,
        "solid_petrol" => " text-teal-700" ,
        "solid_indigo" => " text-indigo-800" ,
        "solid_black" => " text-slate-900" ,
      }[option] || ""
    end
    # need full color names for tailwind to pick it up

    def shade_for( option )
      { "white_25" => " bg-white/25",
        "none" => "",
        "black_25" => " bg-black/25" ,
        "light_blue_25" => " bg-cyan-100/25" ,
        "light_red_25" => " bg-orange-300/25" ,
        "solid_blue_25" => " bg-cyan-700/25" ,
        "solid_red_25" => " bg-orange-800/25" ,
      }[option] || ""
    end
  end
end
