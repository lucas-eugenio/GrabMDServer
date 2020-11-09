class AddDoctorProfileInfo < ActiveRecord::Migration[6.0]
  def change
    add_column :doctors, :phone, :string
    add_column :doctors, :formation, :string
    add_column :doctors, :experiences, :string
  end
end
