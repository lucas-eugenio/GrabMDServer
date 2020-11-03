# frozen_string_literal: true

require 'rails_helper'

module Mutations
  RSpec.describe CreateDoctor do
    let(:mutation) { Mutations::CreateDoctor.new(object: nil, field: nil, context: {}) }

    describe 'Cenário 1' do
      it 'Cria Médico com Sucesso' do
        expect(Doctor.count).to eq(0)

        result = mutation.resolve(
          name: 'Raphael Muzy',
          email: 'raphaelmuzy@email.com',
          crm: '115573',
          password: '123456'
        )

        expect(Doctor.count).to eq(1)
        expect(result[:errors]).to eq(nil)
      end
    end

    describe 'Cenário 2' do
      it 'Erro de CRM Já Cadastrado' do
        create(:doctor)

        expect(Doctor.count).to eq(1)

        result = mutation.resolve(
          name: 'Raphael Muzy',
          email: 'raphaelmuzy@email.com',
          crm: '115573',
          password: '123456'
        )

        expect(Doctor.count).to eq(1)
        expect(result[:errors]).to eq('CRM Já Cadastrado')
      end
    end
  end
end
