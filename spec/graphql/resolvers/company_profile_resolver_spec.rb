# frozen_string_literal: true

require 'rails_helper'

module Resolvers
  RSpec.describe CompanyProfileResolver do
    let(:mutation) { Resolvers::CompanyProfileResolver.new(object: nil, field: nil, context: {}) }
    let(:company) { create(:company) }
    let(:doctor) { create(:doctor) }
    let(:token) { create_token('doctor', doctor.id) }

    describe 'Cenário 1' do
      it 'Mostra o Perfil da Empresa' do
        result = mutation.resolve(token: token, company_id: company.id)

        expect(result[:errors]).to eq(nil)
        expect(result[:company].present?).to eq(true)
        expect(result[:company][:id]).to eq(company.id)
      end
    end
  end
end
