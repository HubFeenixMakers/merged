module Merged
  class ActiveBase < ActiveYaml::Base
    fields :updated_at , :updated_by

    def edit_save( editor )
      self.updated_at = Time.now
      self.updated_by = editor
      edit_save!(editor)
    end

    def edit_save!(editor)
      ChangeSet.current.edit(self.class.name , self.change_name, editor)
      save!()
      self.class.save_all
    end

    def add_save( editor )
      self.updated_at = Time.now
      self.updated_by = editor
      add_save!(editor)
    end

    def add_save!(editor)
      ChangeSet.current.add(self.class.name , self.change_name, editor)
      save!()
      self.class.save_all
    end

    def delete_save!(editor)
      ChangeSet.current.delete(self.class.name , self.change_name,editor)
      self.class.delete(self.id)
      self.class.save_all
    end

    def self.save_all
      data = @records.collect {|obj| obj.attributes}
      File.write( self.full_path , data.to_yaml)
      self.reload(true)
    end

    def self.delete(id) # only works with id's
      @record_index.delete(id.to_s)
      @records.delete_if{|record| record[:id] == id.to_i}
      true
    end

  end
end
