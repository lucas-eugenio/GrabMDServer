# frozen_string_literal: true

module Types
  # GraphQL/Types/JourneyCandidaturesType
  class JourneyCandidaturesType < Types::BaseObject
    field :candidatures, [Types::JourneyType], null: true
    field :doctor, Types::DoctorType, null: true
    field :pagination, Types::PaginationType, null: true
    field :errors, String, null: true
  end
end
