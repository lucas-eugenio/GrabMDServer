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
      token = crypt.encrypt_and_sign("#{token_prefix}:#{user_id}")
      save_token(token)
    end

    def save_token(token)
      context[:session].present? ? context[:session][:token] = token : context[:session] = { token: token }
      token
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
      case token
      when /company/
        Company.find token.gsub('company:', '').to_i
      when /doctor/
        Doctor.find token.gsub('doctor:', '').to_i
      when /manager/
        Manager.find token.gsub('manager:', '').to_i
      end
    end
  end
end
