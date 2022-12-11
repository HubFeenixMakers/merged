require "active_hash"

module ActiveHash
  Base.class_eval do

    def self.delete(id) # only works with id's
      @record_index.delete(id.to_s)
      @records.delete_if{|record| record[:id] == id.to_i}
      true
    end

    def the_private_records
      @records
    end
  end
end
