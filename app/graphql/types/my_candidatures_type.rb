# frozen_string_literal: true

module Types
  # GraphQL/Types/MyCandidaturesType
  class MyCandidaturesType < Types::BaseObject
    field :candidatures, [Types::CandidatureType], null: true
    field :pagination, Types::PaginationType, null: true
    field :errors, String, null: true
  end
end
