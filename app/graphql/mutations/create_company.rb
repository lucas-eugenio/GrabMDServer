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
      company = Company.create!(
        name: name,
        email: email,
        cnpj: cnpj,
        password: password
      )

      { company: company }
    end
  end
end
