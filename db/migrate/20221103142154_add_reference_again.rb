class AddReferenceAgain < ActiveRecord::Migration[5.2]
  def change
    add_reference :batteries, :building, foreign_key: true, first: true
    add_reference :batteries, :employee, foreign_key: true, first: true
    add_reference :building_details, :building, foreign_key: true, first: true
    add_reference :columns, :battery, foreign_key: true, first: true
    add_reference :customers, :user, foreign_key: true, first: true
    add_reference :elevators, :column, foreign_key: true, first: true
    add_reference :employees, :user, foreign_key: true, first: true
    add_reference :buildings, :customer, foreign_key: true, first: true
  end
end
