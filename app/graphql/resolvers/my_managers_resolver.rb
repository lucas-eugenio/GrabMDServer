# frozen_string_literal: true

module Resolvers
  # GraphQL/Resolvers/MyManagersResolver
  class MyManagersResolver < Resolvers::BaseResolver
    argument :token, String, required: true
    argument :page, Integer, required: false
    argument :per_page, Integer, required: false

    type Types::MyManagersType, null: false

    def resolve(token: nil, page: 1, per_page: 5)
      user = current_user(token)
      return { errors: 'Token Incorreto' } unless user
      return { errors: 'Não Autorizado' } unless user.can? :my_managers

      managers = apply_scopes(user)
      pagination = get_pagination(page, managers.count, per_page)
      managers = filter_page(managers, page, per_page)

      { pagination: pagination, managers: managers }
    end

    private

    def apply_scopes(company)
      company.managers.order('id DESC')
    end
  end
end
