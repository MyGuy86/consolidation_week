class CreateIntervention < ActiveRecord::Migration[5.2]
  def change
    create_table :interventions do |t|
      t.string :interventionStart
      t.string :interventionEnd
      t.string :result
      t.string :report 
      t.string :status
    end
  end
end
