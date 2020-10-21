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
      doctor = Doctor.create!(
        name: name,
        email: email,
        crm: crm,
        password: password
      )

      { doctor: doctor }
    end
  end
end
