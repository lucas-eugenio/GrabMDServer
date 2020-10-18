# frozen_string_literal: true

module Mutations
  # GraphQL/Mutations/CreateDoctor
  class CreateDoctor < BaseMutation
    # Type::DoctorAuthProviderSignupData
    class DoctorAuthProviderSignupData < Types::BaseInputObject
      argument :credentials, Types::DoctorAuthProviderCredentialsInput, required: false
    end

    argument :name, String, required: true
    argument :email, String, required: true
    argument :auth_provider, DoctorAuthProviderSignupData, required: false

    type Types::DoctorType

    def resolve(name: nil, email: nil, auth_provider: nil)
      Doctor.create!(
        name: name,
        email: email,
        crm: auth_provider&.[](:credentials)&.[](:crm),
        password: auth_provider&.[](:credentials)&.[](:password)
      )
    end
  end
end
