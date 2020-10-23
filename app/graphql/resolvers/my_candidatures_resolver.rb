# frozen_string_literal: true

module Resolvers
  # GraphQL/Resolvers/MyCandidaturesResolver
  class MyCandidaturesResolver < Resolvers::BaseResolver
    argument :token, String, required: true
    argument :page, Integer, required: false
    argument :per_page, Integer, required: false

    type Types::MyCandidaturesType, null: false

    def resolve(token: nil, page: 1, per_page: 5)
      user = current_user(token)
      return { errors: 'Token Incorreto' } unless user
      return { errors: 'Não Autorizado' } unless user.can? :my_candidatures

      candidatures = apply_scopes(user.id)
      pagination = get_pagination(page, candidatures.count, per_page)
      candidatures = filter_page(candidatures, page, per_page)

      { pagination: pagination, candidatures: candidatures }
    end

    private

    def apply_scopes(doctor_id)
      Candidature.of_doctor(doctor_id)
    end
  end
end
