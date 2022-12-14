module Merged
  module OptionsHelper

    # use options with as many option names as neccessary
    def options(section, *args )
      all = {}
      extra_class = ""
      extra_class = args.pop if args.last.is_a?(String)
      args.each do |option_name|
        hash = send "#{option_name}_option".to_sym , section
        all.merge!(hash) { |key, one, two| one.to_s + " " + two.to_s }
      end
      all[:class] = all[:class] + " #{extra_class}"
      all
    end

    def date_precision(element , date_name)
      precision = element.option("date_precision")
      date = element.option(date_name)
      if( precision == "precise")
        return date.to_formatted_s(:short) + " " + date.year.to_s
      end
      return Date.today if date.blank?
      if(date.day < 10)
        attr = "Beginning"
      elsif date.day < 20
        attr = "Middle"
      else
        attr = "End"
      end
      "#{attr} of #{date.strftime('%B')} #{date.year}"
    end

    # adds prose irrespective of options
    def prose_option(section)
      prose_classes
    end

    def order_option(section , clazz = "")
      if section.has_option?("order")
        clazz += " md:order-last" if section.option('order') == "right"
      end
      {class: clazz}
    end

    def text_align_option(section , clazz = "")
      if section.has_option?("text_align")
        # text-center , text-left , text-right , leave comment for tailwind
        clazz += " text-#{section.option('text_align')}"
      end
      {class: clazz}
    end

    def item_align_option(section , clazz = "")
      if section.has_option?("item_align")
        case section.option("item_align")
        when "left"
          clazz += " justify-start"
        when "right"
          clazz += " justify-end"
        else
          clazz += " justify-center"
        end
      end
      {class: clazz }
    end

    def background_option(section , clazz = "")
      if section.has_option?("background")
        option = section.option('background')
        clazz += bg_for(section)
        clazz += " text-white" if option.include?("solid")
      end
      {class: clazz}
    end

    def margin_option(section , clazz = "")
      if section.has_option?("margin")
        clazz += margin_for(section)
      end
      {class: clazz}
    end

    def color_option(section , clazz = "")
      if section.has_option?("color")
        clazz += color_for(section)
      end
      {class: clazz }
    end

    def shade_option(section , clazz = "")
      if section.has_option?("shade_color")
        clazz += shade_for(section)
      end
      {class: clazz }
    end

    def text_column_option( section)
      option = section.option('columns')
      option = 2 if option.blank?
      case option
      when "3"
        columns = "columns-1 md:columns-2 lg:columns-3"
      when "4"
        columns = "columns-1 md:columns-2 lg:columns-3 xl:columns-4"
      else # two
        columns = "columns-1 md:columns-2"
      end
      {class: columns }
    end

    def column_option(section)
      option = section.option('columns')
      case option
      when "1"
        columns = "grid-cols-1"
      when "3"
        columns = "grid-cols-1 md:grid-cols-2 lg:grid-cols-3"
      when "4"
        columns = "grid-cols-1 md:grid-cols-2 lg:grid-cols-4"
      when "5"
        columns = "grid-cols-1 md:grid-cols-3 lg:grid-cols-5"
      when "6"
        columns = "grid-cols-2 md:grid-cols-4 lg:grid-cols-6"
      else # two
        columns = "grid-cols-1 md:grid-cols-2"
      end
      {class: columns }
    end

    private
    # need full color names for tailwind to pick it up
    def bg_for( section )
      { "white" =>  " bg-white" ,
        "none" =>  "" ,
        "light_blue" => " bg-cyan-100" ,
        "light_gray" => " bg-gray-100" ,
        "light_orange" => " bg-orange-50" ,
        "solid_blue" => " bg-cyan-700" ,
        "solid_red" => " bg-amber-600" ,
        "solid_green" => " bg-green-700" ,
        "solid_petrol" => " bg-teal-700" ,
        "solid_indigo" => " bg-cyan-900" ,
        "solid_black" => " bg-slate-900" ,
      }[section.option('background')] || ""
    end
    # need full margin names for tailwind to pick it up
    def margin_for( section )
      { "0" =>  " m-0" ,
        "none" =>  "" ,
        "20" => " m-20" ,
      }[section.option("margin")] || ""
    end
    # need full color names for tailwind to pick it up
    def color_for( section )
      { "white" => " text-white",
        "none" => "",
        "light_blue" => " text-cyan-100" ,
        "light_gray" => " text-gray-100" ,
        "solid_blue" => " text-cyan-700" ,
        "solid_red" => " text-orange-800" ,
        "solid_green" => " text-green-700" ,
        "solid_petrol" => " text-teal-700" ,
        "solid_indigo" => " text-indigo-800" ,
        "solid_black" => " text-slate-800" ,
      }[section.option("color")] || ""
    end
    # need full color names for tailwind to pick it up

    def shade_for( section )
      { "white_25" => " bg-white/25",
        "none" => "",
        "black_25" => " bg-black/25" ,
        "light_blue_25" => " bg-cyan-100/25" ,
        "light_red_25" => " bg-orange-300/25" ,
        "solid_blue_25" => " bg-cyan-700/25" ,
        "solid_red_25" => " bg-orange-800/25" ,
      }[section.option("shade_color")] || ""
    end
  end
end
