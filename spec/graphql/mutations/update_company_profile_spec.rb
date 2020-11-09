# frozen_string_literal: true

require 'rails_helper'

module Mutations
  RSpec.describe UpdateCompanyProfile do
    let(:mutation) { Mutations::UpdateCompanyProfile.new(object: nil, field: nil, context: {}) }
    let(:company) { create(:company) }
    let(:token) { create_token('company', company.id) }

    describe 'Cenário 1' do
      it 'Atualiza os Dados da Empresa' do
        description = 'Company Description'
        address = '04649-000'
        phone = '+55 11 91234-5678'

        result = mutation.resolve(
          token: token,
          description: description,
          address: address,
          phone: phone
        )

        expect(result[:errors]).to eq(nil)
        expect(result[:company][:description]).to eq(description)
        expect(result[:company][:address]).to eq(address)
        expect(result[:company][:phone]).to eq(phone)
      end
    end
  end
end
