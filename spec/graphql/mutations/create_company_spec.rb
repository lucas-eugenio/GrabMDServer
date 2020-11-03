# frozen_string_literal: true

require 'rails_helper'

module Mutations
  RSpec.describe CreateCompany do
    let(:mutation) { Mutations::CreateCompany.new(object: nil, field: nil, context: {}) }

    describe 'Cenário 1' do
      it 'Cria Empresa com Sucesso' do
        expect(Company.count).to eq(0)

        result = mutation.resolve(
          name: 'Hospital do Coração',
          email: 'hospitalcoração@email.com',
          cnpj: '63.733.327/0001-92',
          password: '123456'
        )

        expect(Company.count).to eq(1)
        expect(result[:errors]).to eq(nil)
      end
    end

    describe 'Cenário 2' do
      it 'Erro de CRM Já Cadastrado' do
        create(:company)

        expect(Company.count).to eq(1)

        result = mutation.resolve(
          name: 'Hospital do Coração',
          email: 'hospitalcoração@email.com',
          cnpj: '63.733.327/0001-92',
          password: '123456'
        )

        expect(Company.count).to eq(1)
        expect(result[:errors]).to eq('CNPJ Já Cadastrado')
      end
    end
  end
end
