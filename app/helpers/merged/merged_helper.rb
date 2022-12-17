require "redcarpet"

module Merged
  module MergedHelper
    include OptionsHelper
    @@renderer = nil

    def renderer
      return @@renderer unless @@renderer.nil?
      options = {hard_wrap: true , autolink: true, no_intra_emphasis: true ,
          safe_links_only: true, no_styles: true ,
          link_attributes: { target: '_blank' }}
      html = Redcarpet::Render::HTML.new(options)
      @@renderer = Redcarpet::Markdown.new(html, options)
    end

    def aspect_ratio image
      x , y = image.aspect_ratio
      "#{x} / #{y}"
    end

    def markdown(text)
      text = text.text unless text.is_a?(String)
      return "" if text.blank?
      renderer.render(text).html_safe
    end
    def field_name(card)
      name = card.header
      name += "*" unless card.option("compulsory") == "no"
      name
    end
    def blue_button( text, url)
      button( text , url , "bg-cyan-200" )
    end
    def yellow_button( text, url)
      button( text , url , "bg-yellow-200" )
    end
    def red_button( text, url)
      button( text , url , "bg-red-200" )
    end
    def green_button( text, url)
      button( text , url , "bg-green-200" )
    end
    def submit_button(text , danger = false )
      clazz = "bg-cyan-200 " #full names, no tricks for tailwind
      clazz = "bg-red-300 " if danger
      clazz += button_classes
      content_tag(:button , class: clazz  , type: :submit) do
        text
      end
    end
    def button(text , url , color)
      link_to(url) do
        content_tag(:button , class: color + " " + button_classes ) do
          text
        end
      end
    end
    def button_classes
      "mr-3 inline-block rounded-lg px-4 py-3 text-md font-medium border border-gray-400"
    end
    # section should be hash with at least 'template' key
    def find_template(section)
      "merged/view/" + section.template
    end

  end
end
