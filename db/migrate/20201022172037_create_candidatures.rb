class CreateCandidatures < ActiveRecord::Migration[6.0]
  def change
    create_table :candidatures do |t|
      t.belongs_to :journey
      t.belongs_to :doctor
      t.string :status

      t.timestamps
    end
  end
end
