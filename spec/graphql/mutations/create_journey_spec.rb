# frozen_string_literal: true

require 'rails_helper'

module Mutations
  RSpec.describe CreateJourney do
    let(:mutation) { Mutations::CreateJourney.new(object: nil, field: nil, context: {}) }

    describe 'Cenário 1' do
      it 'Cria Plantão com Sucesso' do
        company = create(:company)

        expect(Journey.count).to eq(0)

        token = create_token('company', company.id)

        result = mutation.resolve(
          token: token,
          name: 'Porta no H. M. de Barueri',
          date: '2020-10-26 00:00:00 -0300',
          payment_date: '2020-10-27 00:00:00 -0300',
          wage: 1500,
          address: '06463-320',
          payment_method: 'account_debit',
          provides_ppe: true,
          hire_entity: 'individual'
        )

        expect(Journey.count).to eq(1)
        expect(result[:errors]).to eq(nil)
      end
    end
  end
end
