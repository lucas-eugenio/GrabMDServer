# frozen_string_literal: true

require 'test_helper'

module Mutations
  # Test/GraphQL/Mutations/CreateCompanyTest
  class CreateCompanyTest < ActiveSupport::TestCase
    def perform(args = {})
      Mutations::CreateCompany.new(object: nil, field: nil, context: {}).resolve(args)
    end

    test 'Success' do
      company = perform(
        name: 'New Company',
        email: 'new_company@example.com',
        auth_provider: {
          credentials: {
            cnpj: '12.345.678/0001-90',
            password: '[omitted]'
          }
        }
      )

      assert company.persisted?
      assert_equal company.name, 'New Company'
      assert_equal company.email, 'new_company@example.com'
      assert_equal company.cnpj, '12.345.678/0001-90'
    end
  end
end
