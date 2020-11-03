# frozen_string_literal: true

module Mutations
  # GraphQL/Mutations/CreateCompany
  class CreateCompany < BaseMutation
    argument :name, String, required: true
    argument :email, String, required: true
    argument :cnpj, String, required: true
    argument :password, String, required: true

    field :company, Types::CompanyType, null: true
    field :errors, String, null: true

    def resolve(name: nil, email: nil, cnpj: nil, password: nil)
      return { errors: 'CNPJ Já Cadastrado' } if repeated_cnpj(cnpj)
      return { errors: 'Email Já Cadastrado' } if repeated_email(email)

      company = Company.create!(
        name: name,
        email: email,
        cnpj: cnpj,
        password: password
      )

      { company: company }
    end

    private

    def repeated_cnpj(cnpj)
      Company.where(cnpj: cnpj).count.positive?
    end

    def repeated_email(email)
      Company.where(email: email).count.positive?
    end
  end
end
