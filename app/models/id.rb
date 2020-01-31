class Id < ApplicationRecord
  validates :value, presence: true, uniqueness: true
  validates_format_of :value, :with => /\A[A-Z]{3}\z/
end
