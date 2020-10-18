# frozen_string_literal: true

require 'test_helper'

module Mutations
  # Test/GraphQL/Mutations/CreateDoctorTest
  class CreateDoctorTest < ActiveSupport::TestCase
    def perform(args = {})
      Mutations::CreateDoctor.new(object: nil, field: nil, context: {}).resolve(args)
    end

    test 'Success' do
      doctor = perform(
        name: 'New Doctor',
        email: 'new_doctor@example.com',
        auth_provider: {
          credentials: {
            crm: '123456',
            password: '[omitted]'
          }
        }
      )

      assert doctor.persisted?
      assert_equal doctor.name, 'New Doctor'
      assert_equal doctor.email, 'new_doctor@example.com'
      assert_equal doctor.crm, '123456'
    end
  end
end
