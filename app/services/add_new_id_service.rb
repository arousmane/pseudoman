class AddNewIdService
  class << self
    def call
      new_id = FreshId.first

      Id.transaction do 
        Id.create(value: new_id.value)
        new_id.destroy
      end

      new_id.value
    end
  end
end