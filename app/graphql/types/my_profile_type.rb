# frozen_string_literal: true

module Types
  # GraphQL/Types/MyProfileType
  class MyProfileType < Types::BaseObject
    field :doctor, Types::DoctorType, null: true
    field :company, Types::CompanyType, null: true
    field :errors, String, null: true
  end
end
