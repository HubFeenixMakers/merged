module Merged
  class ActiveBase < ActiveYaml::Base

    def save
      ChangeSet.edit(self.class.name , self.change_name)
      super
      self.class.save_all
    end

    def add_save
      ChangeSet.add(self.class.name , self.change_name)
      super.save()
      self.class.save_all
    end


    def delete
      ChangeSet.delete(self.class.name , self.change_name)
      self.class.delete(self.id)
    end

    def destroy
      delete
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
