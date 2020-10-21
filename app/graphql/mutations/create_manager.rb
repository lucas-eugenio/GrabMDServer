# frozen_string_literal: true

module Mutations
  # GraphQL/Mutations/CreateManager
  class CreateManager < BaseMutation
    argument :name, String, required: true
    argument :email, String, required: true
    argument :cpf, String, required: true
    argument :password, String, required: true

    field :manager, Types::ManagerType, null: true
    field :errors, String, null: true

    def resolve(name: nil, email: nil, cpf: nil, password: nil)
      return { errors: 'Não Autorizado' } unless can_user? :create_manager

      manager = Manager.create!(
        name: name,
        email: email,
        cpf: cpf,
        password: password,
        company: context[:current_user]
      )

      { manager: manager }
    end
  end
end
