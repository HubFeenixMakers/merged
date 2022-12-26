module Merged
  module ChangesHelper

    def cms_part? name
      return true if name.include?( Image.root )
      return true if name.include?("merged/")
      false
    end

    def changeset( type , element)
      case type
      when :add
        ChangeSet.current.added( element )
      when :edit
        ChangeSet.current.edited( element )
      when :delete
        ChangeSet.current.deleted( element )
      else
        raise "unrecognized type #{type}"
      end
    end

  end
end
