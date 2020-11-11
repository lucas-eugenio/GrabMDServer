# frozen_string_literal: true

module Mutations
  # GraphQL/Mutations/UpdateCompanyProfile
  class UpdateCompanyProfile < BaseMutation
    argument :token, String, required: true
    argument :description, String, required: false
    argument :address, String, required: false
    argument :phone, String, required: false

    field :company, Types::CompanyType, null: true
    field :errors, String, null: true

    def resolve(token: nil, description: nil, address: nil, phone: nil)
      company = current_user(token)
      return { errors: 'Token Incorreto' } unless company
      return { errors: 'Não Autorizado' } unless company.can? :update_company_profile

      company.update!(
        description: description,
        address: address,
        phone: phone
      )

      { company: company }
    end
  end
end
