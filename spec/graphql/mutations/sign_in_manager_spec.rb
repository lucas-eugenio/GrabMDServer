# frozen_string_literal: true

require 'rails_helper'

module Mutations
  RSpec.describe SignInManager do
    let(:mutation) { Mutations::SignInManager.new(object: nil, field: nil, context: {}) }

    describe 'Cenário 1' do
      it 'Autentica Gestor com Sucesso' do
        create(:manager)

        result = mutation.resolve(
          cpf: '156.535.950-04',
          password: '123456'
        )

        expect(result[:token]).not_to be(nil)
        expect(result[:errors]).to eq(nil)
      end
    end

    describe 'Cenário 2' do
      it 'Erro de Senha Incorreta' do
        create(:manager)

        result = mutation.resolve(
          cpf: '156.535.950-04',
          password: '123457'
        )

        expect(result[:token]).to eq(nil)
        expect(result[:errors]).to eq('Senha Incorreta')
      end
    end

    describe 'Cenário 3' do
      it 'Erro de Gestor Não Cadastrado' do
        create(:manager)

        result = mutation.resolve(
          cpf: '156.535.950-05',
          password: '123456'
        )

        expect(result[:token]).to eq(nil)
        expect(result[:errors]).to eq('Usuário Não Cadastrado')
      end
    end
  end
end
