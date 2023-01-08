module Merged
  module PagesHelper
    def last_blog
      sections = Section.all.select{|s| s.page.type == "blog"}
      sorted = sections.sort_by(&:updated_at)
      last =  sorted.pop
      puts last.template.class
      puts last.template
      if (last&.template == "blog_header") or (last&.template == "section_news")
        return sorted.last
      end
      return last
    end

    def header_list
      markdown("- one \n- two\n- three\n- four")
    end
  end
end
