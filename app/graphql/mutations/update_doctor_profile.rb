# frozen_string_literal: true

module Mutations
  # GraphQL/Mutations/UpdateDoctorProfile
  class UpdateDoctorProfile < BaseMutation
    argument :token, String, required: true
    argument :phone, String, required: true
    argument :formation, String, required: true
    argument :experiences, String, required: true

    field :doctor, Types::DoctorType, null: true
    field :errors, String, null: true

    def resolve(token: nil, phone: nil, formation: nil, experiences: nil)
      doctor = current_user(token)
      return { errors: 'Token Incorreto' } unless doctor
      return { errors: 'Não Autorizado' } unless doctor.can? :doctor_profile

      doctor.update!(
        phone: phone,
        formation: formation,
        experiences: experiences
      )

      { doctor: doctor }
    end
  end
end
