# frozen_string_literal: true

module Mutations
  # GraphQL/Mutations/CreateManager
  class CreateManager < BaseMutation
    argument :token, String, required: true
    argument :name, String, required: true
    argument :email, String, required: true
    argument :cpf, String, required: true
    argument :password, String, required: true

    field :manager, Types::ManagerType, null: true
    field :errors, String, null: true

    def resolve(token: nil, name: nil, email: nil, cpf: nil, password: nil)
      user = current_user(token)
      return { errors: 'Token Incorreto' } unless user
      return { errors: 'Não Autorizado' } unless user.can? :create_manager

      manager = create_manager(user, name, email, cpf, password)
      { manager: manager }
    end

    private

    def create_manager(company, name, email, cpf, password)
      Manager.create!(
        name: name,
        email: email,
        cpf: cpf,
        password: password,
        company: company
      )
    end
  end
end
