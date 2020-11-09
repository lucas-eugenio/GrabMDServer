# frozen_string_literal: true

module Resolvers
  # GraphQL/Resolvers/JourneyCandidaturesResolver
  class JourneyCandidaturesResolver < Resolvers::BaseResolver
    argument :token, String, required: true
    argument :journey_id, ID, required: true
    argument :page, Integer, required: false
    argument :per_page, Integer, required: false

    type Types::JourneyCandidaturesType, null: false

    def resolve(token: nil, journey_id: nil, page: 1, per_page: 5)
      user = current_user(token)
      return { errors: 'Token Incorreto' } unless user
      return { errors: 'Não Autorizado' } unless user.can? :journey_candidatures

      journey = Journey.find_by_id(journey_id)

      return { errors: 'Plantão Não Existe' } unless journey.present?
      return { errors: 'Não Autorizado' } unless journey.company_id == user.company.id

      candidatures = apply_scopes(journey)
      pagination = get_pagination(page, candidatures.count, per_page)
      candidatures = filter_page(candidatures, page, per_page)

      { pagination: pagination, candidatures: candidatures, doctor: journey.doctor }
    end

    private

    def apply_scopes(journey)
      journey.candidatures.order('id ASC')
    end
  end
end
