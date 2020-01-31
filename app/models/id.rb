class Id < ApplicationRecord
  validates :value, presence: true, uniqueness: true
  validates_format_of :value, :with => /\A[A-Z]{3}\z/


  def self.lock(id)
    $redis.setex(id, 300, 'locked')
  end

  def self.locked?(id)
    !$redis.get(id).nil?
  end
end
