# frozen_string_literal: true

module Mutations
  # GraphQL/Mutations/BaseMutation
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject

    private

    def create_token(token_prefix, user_id)
      crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
      # Token for MVP, Use a Service Like JWT on Real Server
      crypt.encrypt_and_sign("#{token_prefix}:#{user_id}")
    end

    def can_user?(token, permission)
      current_user(token).permissions[permission]
    end

    def current_user(token)
      return unless token

      crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
      token = crypt.decrypt_and_verify token
      find_user(token)
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      nil
    end

    def find_user(token)
      token_to_id = ->(prefix) { token.gsub("#{prefix}:", '').to_i }

      case token
      when /company/
        Company.find token_to_id.call('company')
      when /doctor/
        Doctor.find token_to_id.call('doctor')
      when /manager/
        Manager.find token_to_id.call('manager')
      end
    end
  end
end
