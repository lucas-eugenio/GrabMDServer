# frozen_string_literal: true

module Mutations
  # GraphQL/Mutations/CreateCompany
  class CreateCompany < BaseMutation
    # Type::CompanyAuthProviderSignupData
    class CompanyAuthProviderSignupData < Types::BaseInputObject
      argument :credentials, Types::CompanyAuthProviderCredentialsInput, required: false
    end

    argument :name, String, required: true
    argument :email, String, required: true
    argument :auth_provider, CompanyAuthProviderSignupData, required: false

    type Types::CompanyType

    def resolve(name: nil, email: nil, auth_provider: nil)
      Company.create!(
        name: name,
        email: email,
        cnpj: auth_provider&.[](:credentials)&.[](:cnpj),
        password: auth_provider&.[](:credentials)&.[](:password)
      )
    end
  end
end
