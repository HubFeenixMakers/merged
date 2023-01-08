module Merged
  module PagesHelper
    def last_blog
      sections = Section.all.select{|s| s.page.type == "blog"}
      sorted = sections.sort_by(&:updated_at)
      last =  sorted.pop
      puts last.template
      return last unless last&.template == "blog_header"
      return last unless last&.template == "section_news"
      sorted.last
    end
  end
end
