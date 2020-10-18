# frozen_string_literal: true

module Types
  # GraphQL/Types/DoctorAuthProviderCredentialsInput
  class DoctorAuthProviderCredentialsInput < BaseInputObject
    graphql_name 'DOCTOR_AUTH_CREDENTIALS'

    argument :crm, String, required: true
    argument :password, String, required: true
  end
end
