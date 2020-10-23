class AddUniqueIndexToCandidatures < ActiveRecord::Migration[6.0]
  def change
    add_index :candidatures, [:doctor, :journey], unique: true
  end
end
