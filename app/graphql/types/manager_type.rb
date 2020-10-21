# frozen_string_literal: true

module Types
  # GraphQL/Types/ManagerType
  class ManagerType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :cpf, String, null: false
    field :company, CompanyType, null: true, method: :company
  end
end
