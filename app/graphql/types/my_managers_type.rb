# frozen_string_literal: true

module Types
  # GraphQL/Types/MyManagersType
  class MyManagersType < Types::BaseObject
    field :managers, [Types::ManagerType], null: true
    field :pagination, Types::PaginationType, null: true
    field :errors, String, null: true
  end
end
