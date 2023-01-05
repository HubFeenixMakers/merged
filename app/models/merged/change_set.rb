module Merged
  class ChangeSet


    def self.current
      @@current ||= ChangeSet.new
    end
    attr_reader :adds , :edits , :deletes

    def initialize
      zero
    end

    def zero
      [Page, Section, Card].each { |m| m.reload(true) }
      @adds = Set.new
      @edits = Set.new
      @deletes = Set.new
    end

    def add( type , text)
      @adds << [typed(type) , text ]
    end

    def edit( type , text)
      @edits << [typed(type) , text ]
    end
    def delete( type , text)
      @deletes << [typed(type) , text ]
    end

    def added( type )
      type = type.to_sym
      @adds.select { |a| a.first == type }
    end
    def edited( type )
      type = type.to_sym
      @edits.select { |a| a.first == type }
    end
    def deleted( type )
      type = type.to_sym
      @deletes.select { |a| a.first == type }
    end

    def typed(class_name)
      class_name.split("::").last.to_sym
    end
  end
end
