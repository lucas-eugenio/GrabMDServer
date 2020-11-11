# frozen_string_literal: true

module Types
  # GraphQL/Types/DoctorProfileType
  class DoctorProfileType < Types::BaseObject
    field :doctor, Types::DoctorType, null: true
    field :errors, String, null: true
  end
end
