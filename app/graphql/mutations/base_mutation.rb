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

    def user
      context[:current_user]
    end

    def can_user?(permission)
      user.permissions[permission]
    end
  end
end
