class Employee < ApplicationRecord
    has_many :battery
    belongs_to :user
    has_many :intervention
end
