# frozen_string_literal: true

module Mutations
  # GraphQL/Mutations/CreateDoctor
  class CreateDoctor < BaseMutation

    argument :name, String, required: true
    argument :email, String, required: true
    argument :crm, String, required: true
    argument :password, String, required: true

    field :doctor, Types::DoctorType, null: true
    field :errors, String, null: true

    def resolve(name: nil, email: nil, crm: nil, password: nil)
      return { errors: 'CRM Já Cadastrado' } if repeated_crm(crm)
      return { errors: 'Email Já Cadastrado' } if repeated_email(email)

      doctor = Doctor.create!(
        name: name,
        email: email,
        crm: crm,
        password: password
      )

      { doctor: doctor }
    end

    private

    def repeated_crm(crm)
      Doctor.where(crm: crm).count.positive?
    end

    def repeated_email(email)
      Doctor.where(email: email).count.positive?
    end
  end
end
