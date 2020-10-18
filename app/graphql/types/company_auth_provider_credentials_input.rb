# frozen_string_literal: true

module Types
  # GraphQL/Types/CompanyAuthProviderCredentialsInput
  class CompanyAuthProviderCredentialsInput < BaseInputObject
    graphql_name 'COMPANY_AUTH_CREDENTIALS'

    argument :cnpj, String, required: true
    argument :password, String, required: true
  end
end
