# frozen_string_literal: true

require 'rails_helper'

module Mutations
  RSpec.describe SignInDoctor do
    let(:mutation) { Mutations::SignInDoctor.new(object: nil, field: nil, context: {}) }

    describe 'Cenário 1' do
      it 'Autentica Médico com Sucesso' do
        create(:doctor)

        result = mutation.resolve(
          crm: '115573',
          password: '123456'
        )

        expect(result[:token]).not_to be(nil)
        expect(result[:errors]).to eq(nil)
      end
    end

    describe 'Cenário 2' do
      it 'Erro de Senha Incorreta' do
        create(:doctor)

        result = mutation.resolve(
          crm: '115573',
          password: '123457'
        )

        expect(result[:token]).to eq(nil)
        expect(result[:errors]).to eq('Senha Incorreta')
      end
    end

    describe 'Cenário 3' do
      it 'Erro de Médico Não Cadastrado' do
        create(:doctor)

        result = mutation.resolve(
          crm: '123456',
          password: '123456'
        )

        expect(result[:token]).to eq(nil)
        expect(result[:errors]).to eq('Médico Não Cadastrado')
      end
    end
  end
end
