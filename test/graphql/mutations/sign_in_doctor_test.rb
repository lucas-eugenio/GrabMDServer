# frozen_string_literal: true

require 'test_helper'

module Mutations
  # Test/GraphQL/Mutations/SignInDoctorTest
  class SignInDoctorTest < ActiveSupport::TestCase
    def perform(args = {})
      Mutations::SignInDoctor.new(object: nil, field: nil, context: { session: {} }).resolve(args)
    end

    def create_doctor
      Doctor.create!(
        name: 'New Doctor',
        email: 'new_doctor@example.com',
        crm: '123456',
        password: '[omitted]'
      )
    end

    test 'Success' do
      doctor = create_doctor

      result = perform(
        credentials: {
          crm: doctor.crm,
          password: doctor.password
        }
      )

      assert result[:token].present?
      assert_equal result[:doctor], doctor
    end

    test 'Failure Because no Credentials' do
      assert_nil perform
    end

    test 'Failure Because Wrong CRM' do
      create_doctor
      assert_nil perform(credentials: { crm: 'wrong' })
    end

    test 'Failure Because Wrong Password' do
      doctor = create_doctor
      assert_nil perform(credentials: { crm: doctor.crm, password: 'wrong' })
    end
  end
end
