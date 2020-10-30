# frozen_string_literal: true

module Types
  # GraphQL/Types/JourneyType
  class JourneyType < Types::BaseObject
    # Required Fields
    field :id, ID, null: false
    field :name, String, null: false
    field :date, String, null: false
    field :payment_date, String, null: false
    field :wage, Float, null: false
    field :address, String, null: false
    field :company, Types::CompanyType, null: true, method: :company

    # Optional Fields
    field :payment_method, Types::PaymentMethodType, null: true
    field :provides_ppe, Boolean, null: true
    field :hire_entity, Types::HireEntityType, null: true
    field :doctor, Types::DoctorType, null: true

    # Extra
    field :candidatures, [Types::CandidatureType], null: true
  end
end
