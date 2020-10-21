class CreateManagers < ActiveRecord::Migration[6.0]
  def change
    create_table :managers do |t|
      t.belongs_to :company
      t.string :name
      t.string :email
      t.string :cpf
      t.string :password_digest

      t.timestamps
    end
  end
end
