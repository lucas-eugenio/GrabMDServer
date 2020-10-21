# frozen_string_literal: true

module Types
  # GraphQL/Types/PaymentMethodType
  class PaymentMethodType < Types::BaseEnum
    value('ACCOUNT_DEBIT', description: 'Account Debit', value: 'account_debit')
  end
end
