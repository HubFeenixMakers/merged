require "active_hash"

module ActiveYaml
  Base.class_eval do

    def save
      super
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

    def self.the_private_records
      @records
    end
  end
end
