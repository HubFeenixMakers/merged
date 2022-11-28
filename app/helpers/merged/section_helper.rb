module Merged::SectionHelper

  def section_form(options)
    url = merge_page_section_url( @page.id , @section.id)
    puts "URL #{url}"
    form_tag( url , {method: :patch}) do
      yield
    end
  end
end
