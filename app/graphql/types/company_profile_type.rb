# frozen_string_literal: true

module Types
  # GraphQL/Types/CompanyProfileType
  class CompanyProfileType < Types::BaseObject
    field :company, Types::CompanyType, null: true
    field :errors, String, null: true
  end
end
