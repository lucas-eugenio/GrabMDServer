# frozen_string_literal: true

require 'rails_helper'

module Mutations
  RSpec.describe SignInCompany do
    let(:mutation) { Mutations::SignInCompany.new(object: nil, field: nil, context: {}) }

    describe 'Cenário 1' do
      it 'Autentica Empresa com Sucesso' do
        create(:company)

        result = mutation.resolve(
          cnpj: '63.733.327/0001-92',
          password: '123456'
        )

        expect(result[:token]).not_to be(nil)
        expect(result[:errors]).to eq(nil)
      end
    end

    describe 'Cenário 2' do
      it 'Erro de Senha Incorreta' do
        create(:company)

        result = mutation.resolve(
          cnpj: '63.733.327/0001-92',
          password: '123457'
        )

        expect(result[:token]).to eq(nil)
        expect(result[:errors]).to eq('Senha Incorreta')
      end
    end

    describe 'Cenário 3' do
      it 'Erro de Empresa Não Cadastrado' do
        create(:company)

        result = mutation.resolve(
          cnpj: '123456',
          password: '123456'
        )

        expect(result[:token]).to eq(nil)
        expect(result[:errors]).to eq('Empresa Não Cadastrada')
      end
    end
  end
end
