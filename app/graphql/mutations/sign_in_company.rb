# frozen_string_literal: true

module Mutations
  # GraphQL/Mutations/SignInCompany
  class SignInCompany < BaseMutation
    null true

    argument :credentials, Types::CompanyAuthProviderCredentialsInput, required: false

    field :token, String, null: true
    field :company, Types::CompanyType, null: true

    def resolve(credentials: nil)
      return unless credentials

      company = Company.find_by cnpj: credentials[:cnpj]

      return unless company
      return unless company.authenticate(credentials[:password])

      crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
      # Token for MVP, Use a Service Like JWT on Real Server
      token = crypt.encrypt_and_sign("company-id:#{company.id}")

      { company: company, token: token }
    end
  end
end
