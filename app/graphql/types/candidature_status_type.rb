# frozen_string_literal: true

module Types
  # GraphQL/Types/CandidatureStatusType
  class CandidatureStatusType < Types::BaseEnum
    value('IN_PROGRESS', description: 'In Progress', value: 'in_progress')
    value('ACCEPTED', description: 'Doctor Accepted', value: 'accepted')
    value('REFUSED', description: 'Doctor Refused', value: 'refused')
  end
end
