class CreateJourneys < ActiveRecord::Migration[6.0]
  def change
    create_table :journeys do |t|
      t.belongs_to :company
      t.belongs_to :doctor
      t.string :name
      t.datetime :date
      t.datetime :payment_date
      t.string :payment_method
      t.float :wage
      t.boolean :provides_ppe
      t.string :hire_entity
      t.string :address

      t.timestamps
    end
  end
end
