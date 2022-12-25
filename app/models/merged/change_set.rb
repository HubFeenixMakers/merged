module Merged
  module ChangeSet
    @@adds = []
    @@edits = []
    @@deletes = []

    mattr_accessor :adds , :edits , :deletes

    def self.add( type , text)
      @@adds << [typed(type) , text ]
    end

    def self.edit( type , text)
      @@edits << [typed(type) , text ]
    end
    def self.delete( type , text)
      @@deletes << [typed(type) , text ]
    end

    def self.added( type )
      type = type.to_sym
      @@adds.select { |a| a.first == type }
    end
    def self.edited( type )
      type = type.to_sym
      @@edits.select { |a| a.first == type }
    end
    def self.deleted( type )
      type = type.to_sym
      @@deletes.select { |a| a.first == type }
    end

    def self.typed(class_name)
      class_name.split("::").last.to_sym
    end
  end
end
