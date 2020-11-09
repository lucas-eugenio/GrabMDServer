# frozen_string_literal: true

module Types
  # GraphQL/Types/DoctorType
  class DoctorType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :crm, String, null: false
    field :phone, String, null: true
    field :formation, String, null: true
    field :experiences, String, null: true
  end
end
