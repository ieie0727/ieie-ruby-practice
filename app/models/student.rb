class Student < ApplicationRecord
  validates :num, uniqueness: true
end
