# frozen_string_literal: true

require 'rails_helper'

module Mutations
  RSpec.describe CreateManager do
    let(:mutation) { Mutations::CreateManager.new(object: nil, field: nil, context: {}) }
    let(:company) { create(:company) }
    let(:token) { create_token('company', company.id) }

    describe 'Cenário 1' do
      it 'Cria Gestor com Sucesso' do
        expect(Manager.count).to eq(0)

        result = mutation.resolve(
          token: token,
          name: 'First Manager',
          email: 'firstmanager@email.com',
          cpf: '156.535.950-04',
          password: '123456'
        )

        expect(Manager.count).to eq(1)
        expect(result[:errors]).to eq(nil)
      end
    end

    describe 'Cenário 2' do
      it 'Erro de CPF Já Cadastrado' do
        create(:manager, company: company)

        expect(Manager.count).to eq(1)

        result = mutation.resolve(
          token: token,
          name: 'First Manager',
          email: 'firstmanager@email.com',
          cpf: '156.535.950-04',
          password: '123456'
        )

        expect(Manager.count).to eq(1)
        expect(result[:errors]).to eq('CPF Já Cadastrado')
      end
    end
  end
end
