# frozen_string_literal: true

module Resolvers
  # GraphQL/Resolvers/MyProfileResolver
  class MyProfileResolver < Resolvers::BaseResolver
    argument :token, String, required: true

    type Types::MyProfileType, null: false

    def resolve(token: nil)
      user = current_user(token)
      return { errors: 'Token Incorreto' } unless user
      return { errors: 'Não Autorizado' } unless user.can? :my_profile

      case user.class.name
      when 'Company'
        return { company: user }
      when 'Doctor'
        return { doctor: user }
      end

      { errors: 'Ops, Algo deu Errado' }
    end
  end
end
