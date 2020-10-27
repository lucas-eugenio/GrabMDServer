# frozen_string_literal: true

module Resolvers
  # GraphQL/Resolvers/MyJourneysResolver
  class MyJourneysResolver < Resolvers::BaseResolver
    argument :token, String, required: true
    argument :page, Integer, required: false
    argument :per_page, Integer, required: false

    type Types::MyJourneysType, null: false

    def resolve(token: nil, page: 1, per_page: 5)
      user = current_user(token)
      return { errors: 'Token Incorreto' } unless user
      return { errors: 'Não Autorizado' } unless user.can? :my_journeys

      journeys = apply_scopes(user)
      pagination = get_pagination(page, journeys.count, per_page)
      journeys = filter_page(journeys, page, per_page)

      { pagination: pagination, journeys: journeys }
    end

    private

    def apply_scopes(user)
      user.company.journeys.order('created_at DESC')
    end
  end
end
