# frozen_string_literal: true

module Types
  # GraphQL/Types/CompanyType
  class CompanyType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :cnpj, String, null: false
  end
end
