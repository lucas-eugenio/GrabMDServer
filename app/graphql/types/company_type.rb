# frozen_string_literal: true

module Types
  # GraphQL/Types/CompanyType
  class CompanyType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :cnpj, String, null: false
    field :description, String, null: true
    field :address, String, null: true
    field :phone, String, null: true
  end
end
