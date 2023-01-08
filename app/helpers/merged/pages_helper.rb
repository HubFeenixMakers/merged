module Merged
  module PagesHelper
    def last_blog
      blog = Page.where(type: :blog).order(updated_at: :asc).first
      blog&.sections.last
    end

    def header_list
      return "" unless blog_section = last_blog
      blog = blog_section.page
      headers = blog.sections.collect{|s| "- " + s.header}
      headers.shift
      return "" if headers.empty?
      markdown headers.join("\n")
    end
  end
end
