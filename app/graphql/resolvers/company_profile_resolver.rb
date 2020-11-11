# frozen_string_literal: true

module Resolvers
  # GraphQL/Resolvers/DoctorProfileResolver
  class CompanyProfileResolver < Resolvers::BaseResolver
    argument :token, String, required: true
    argument :company_id, String, required: true

    type Types::DoctorProfileType, null: false

    def resolve(token: nil, company_id: nil)
      user = current_user(token)
      return { errors: 'Token Incorreto' } unless user
      return { errors: 'Não Autorizado' } unless user.can? :company_profile

      company = Company.find_by_id(company_id)
      return { errors: 'Empresa Não Existe' } unless company.present?

      { company: company }
    end
  end
end
