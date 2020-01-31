class GenerateAndStoreIdService
  class << self
    def call
      id = next_id
      while(Id.locked?(id))
        id = next_id(id)
      end
  
      Id.lock(id)
      Id.create(value: id)
      
      id
    end
    
    def next_id(id = nil)
      return Id.maximum(:value).next[0..2] if id.nil?
  
      id.next[0..2]
    end
  end
end