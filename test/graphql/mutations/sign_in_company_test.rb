# frozen_string_literal: true

require 'test_helper'

module Mutations
  # Test/GraphQL/Mutations/SignInCompanyTest
  class SignInCompanyTest < ActiveSupport::TestCase
    def perform(args = {})
      Mutations::SignInCompany.new(object: nil, field: nil, context: { session: {} }).resolve(args)
    end

    def create_company
      Company.create!(
        name: 'New Company',
        email: 'new_company@example.com',
        cnpj: '12.345.678/0001-90',
        password: '[omitted]'
      )
    end

    test 'Success' do
      company = create_company

      result = perform(
        credentials: {
          cnpj: company.cnpj,
          password: company.password
        }
      )

      assert result[:token].present?
      assert_equal result[:company], company
    end

    test 'Failure Because no Credentials' do
      assert_nil perform
    end

    test 'Failure Because Wrong CNPJ' do
      create_company
      assert_nil perform(credentials: { cnpj: 'wrong' })
    end

    test 'Failure Because Wrong Password' do
      company = create_company
      assert_nil perform(credentials: { cnpj: company.cnpj, password: 'wrong' })
    end
  end
end
