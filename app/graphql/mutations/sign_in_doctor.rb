# frozen_string_literal: true

module Mutations
  # GraphQL/Mutations/SignInDoctor
  class SignInDoctor < BaseMutation
    argument :crm, String, required: true
    argument :password, String, required: true

    field :token, String, null: true
    field :doctor, Types::DoctorType, null: true
    field :errors, String, null: true

    def resolve(crm: nil, password: nil)
      return { errors: 'Credencias Não Informadas' } unless crm && password

      doctor = Doctor.find_by crm: crm

      return { errors: 'Médico Não Cadastrado' } unless doctor
      return { errors: 'Senha Incorreta' } unless doctor.authenticate(password)

      token = create_token('doctor', doctor.id)

      { doctor: doctor, token: token }
    end
  end
end
