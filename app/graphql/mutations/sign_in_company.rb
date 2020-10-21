# frozen_string_literal: true

module Mutations
  # GraphQL/Mutations/SignInCompany
  class SignInCompany < BaseMutation
    argument :cnpj, String, required: true
    argument :password, String, required: true

    field :token, String, null: true
    field :company, Types::CompanyType, null: true
    field :errors, String, null: true

    def resolve(cnpj: nil, password: nil)
      return { errors: 'Credencias Não Informadas' } unless cnpj && password

      company = Company.find_by cnpj: cnpj

      return { errors: 'Empresa Não Cadastrada' } unless company
      return { errors: 'Senha Incorreta' } unless company.authenticate(password)

      token = create_token('company', company.id)

      { company: company, token: token }
    end
  end
end
