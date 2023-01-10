module Merged
  module PagesHelper
    def self.last_blog
      blog = Page.where(type: :blog).order(updated_at: :asc).first
      return  nil unless blog
      blog.sections.last
    end
    def last_blog
      self.class.last_blog
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
