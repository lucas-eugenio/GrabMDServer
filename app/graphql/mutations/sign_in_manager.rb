# frozen_string_literal: true

module Mutations
  # GraphQL/Mutations/SignInManager
  class SignInManager < BaseMutation
    argument :cpf, String, required: true
    argument :password, String, required: true

    field :token, String, null: true
    field :manager, Types::ManagerType, null: true
    field :errors, String, null: true

    def resolve(cpf: nil, password: nil)
      return { errors: 'Credencias Não Informadas' } unless cpf && password

      manager = Manager.find_by cpf: cpf

      return { errors: 'Usuário Não Cadastrado' } unless manager
      return { errors: 'Senha Incorreta' } unless manager.authenticate(password)

      token = create_token('manager', manager.id)

      { manager: manager, token: token }
    end
  end
end
