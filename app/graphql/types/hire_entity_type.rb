# frozen_string_literal: true

module Types
  # GraphQL/Types/HireEntityType
  class HireEntityType < Types::BaseEnum
    value('INDIVIDUAL', description: 'Individual Person', value: 'individual')
    value('LEGAL', description: 'Legal Person', value: 'legal')
    value('BOTH', description: 'Individual or Legal Person', value: 'both')
  end
end
