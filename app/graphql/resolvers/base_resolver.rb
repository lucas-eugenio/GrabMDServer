# frozen_string_literal: true

module Resolvers
  # GraphQL/Resolvers/BaseResolver
  class BaseResolver < GraphQL::Schema::Resolver
    private

    def get_pagination(page, total, per)
      page_count = total / per + ((total % per).positive? ? 1 : 0)
      { page: page || 1, page_count: page_count }
    end

    def filter_page(records, page, per)
      records.limit(per).offset(per * (page - 1))
    end

    def can_user?(token, permission)
      current_user(token).permissions[permission]
    end

    def current_user(token)
      return unless token

      crypt = ActiveSupport::MessageEncryptor.new('l5p0FysUWuWD8L9yo6CNPE7hsilXLxFf')
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
