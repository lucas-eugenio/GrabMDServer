class AddCompanyProfileInfo < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :description, :string
    add_column :companies, :address, :string
    add_column :companies, :phone, :string
  end
end
