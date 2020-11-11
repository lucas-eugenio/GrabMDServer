# frozen_string_literal: true

module Resolvers
  # GraphQL/Resolvers/DoctorProfileResolver
  class DoctorProfileResolver < Resolvers::BaseResolver
    argument :token, String, required: true
    argument :doctor_id, String, required: true

    type Types::DoctorProfileType, null: false

    def resolve(token: nil, doctor_id: nil)
      user = current_user(token)
      return { errors: 'Token Incorreto' } unless user
      return { errors: 'Não Autorizado' } unless user.can? :doctor_profile

      doctor = Doctor.find_by_id(doctor_id)
      return { errors: 'Médico Não Existe' } unless doctor.present?

      { doctor: doctor }
    end
  end
end
