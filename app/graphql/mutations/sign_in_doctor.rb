# frozen_string_literal: true

module Mutations
  # GraphQL/Mutations/SignInDoctor
  class SignInDoctor < BaseMutation
    null true

    argument :credentials, Types::DoctorAuthProviderCredentialsInput, required: false

    field :token, String, null: true
    field :doctor, Types::DoctorType, null: true

    def resolve(credentials: nil)
      return unless credentials

      doctor = Doctor.find_by crm: credentials[:crm]

      return unless doctor
      return unless doctor.authenticate(credentials[:password])

      crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
      # Token for MVP, Use a Service Like JWT on Real Server
      token = crypt.encrypt_and_sign("doctor-id:#{doctor.id}")

      { doctor: doctor, token: token }
    end
  end
end
