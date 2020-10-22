# frozen_string_literal: true

module Types
  # GraphQL/Types/CandidatureType
  class CandidatureType < Types::BaseObject
    field :id, ID, null: false
    field :journey, Types::JourneyType, null: false
    field :doctor, Types::DoctorType, null: false
    field :status, Types::CandidatureStatusType, null: false
  end
end
