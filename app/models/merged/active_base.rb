module Merged
  class ActiveBase < ActiveYaml::Base

    def edit_save!
      ChangeSet.current.edit(self.class.name , self.change_name)
      save!()
      self.class.save_all
    end

    def add_save!
      ChangeSet.current.add(self.class.name , self.change_name)
      save!()
      self.class.save_all
    end

    def delete_save!
      ChangeSet.current.delete(self.class.name , self.change_name)
      self.class.delete(self.id)
      self.class.save_all
    end

    def self.save_all
      data = @records.collect {|obj| obj.attributes}
      File.write( self.full_path , data.to_yaml)
      self.reload
    end

    def self.delete(id) # only works with id's
      @record_index.delete(id.to_s)
      @records.delete_if{|record| record[:id] == id.to_i}
      true
    end

  end
end
