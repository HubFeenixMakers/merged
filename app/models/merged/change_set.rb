module Merged
  class ChangeSet


    def self.current
      @@current ||= ChangeSet.new
    end
    attr_reader :adds , :edits , :deletes , :last , :last_editor

    def initialize
      zero
    end

    def zero
      [Page, Section, Card].each { |m| m.reload(true) }
      @adds = Set.new
      @edits = Set.new
      @deletes = Set.new
      @last = nil
      @last_editor = nil
    end

    def touch(editor)
      @last = Time.now
      @last_editor = editor
    end

    def add( type , text , editor)
      touch(editor)
      @adds << [typed(type) , text ]
    end

    def edit( type , text, editor)
      touch(editor)
      @edits << [typed(type) , text ]
    end
    def delete( type , text, editor)
      touch(editor)
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
