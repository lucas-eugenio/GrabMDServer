# frozen_string_literal: true

require 'rails_helper'

module Resolvers
  RSpec.describe FindJourneysResolver do
    let(:resolver) { Resolvers::FindJourneysResolver.new(object: nil, field: nil, context: {}) }
    let(:company) { create(:company) }
    let(:doctor) { create(:doctor) }
    let(:token) { create_token('doctor', doctor.id) }

    before do
      create(:journey, company: company)
      create(:journey, name: 'Setor Emergência no Hospital do Coração', company: company, provides_ppe: true)
      create(:journey, name: 'Setor Observação no H. Paulista', company: company, date: '2020-11-02 12:00:00 -0300')
      create(:journey, name: 'Plantão no clube XYZ', company: company, date: '2020-11-11 12:00:00 -0300')
    end

    describe 'Cenário 1' do
      it 'Encontro as Duas Primeiras Vagas' do
        result = resolver.resolve(
          token: token, start_date: '2020-10-26 00:00:00 -0300',
          end_date: '2020-10-26 23:59:59 -0300', address: '04649-000'
        )

        expect(result[:errors]).to eq(nil)
        expect(result[:journeys].count).to eq(2)
        expect(result[:journeys]).to include(Journey.first)
        expect(result[:journeys]).to include(Journey.second)
      end
    end

    describe 'Cenário 2' do
      it 'Encontro Todas as Quatro Vagas' do
        result = resolver.resolve(token: token)

        expect(result[:errors]).to eq(nil)
        expect(result[:journeys].count).to eq(4)
        expect(result[:journeys]).to include(Journey.first)
        expect(result[:journeys]).to include(Journey.second)
        expect(result[:journeys]).to include(Journey.third)
        expect(result[:journeys]).to include(Journey.fourth)
      end
    end

    describe 'Cenário 3' do
      it 'Encontro a Segunda Vaga' do
        result = resolver.resolve(
          token: token,
          start_date: '2020-10-26 00:00:00 -0300',
          end_date: '2020-10-26 23:59:59 -0300',
          end_payment_date: '2020-11-02 12:00:00 -0300',
          wage: 1500,
          address: '04649-000',
          payment_method: 'account_debit',
          provides_ppe: true,
          hire_entity: 'individual'
        )

        expect(result[:errors]).to eq(nil)
        expect(result[:journeys].count).to eq(1)
        expect(result[:journeys]).to include(Journey.second)
      end
    end

    describe 'Cenário 4' do
      it 'Não Encontro Nenhuma Vaga' do
        result = resolver.resolve(
          token: token, start_date: '2025-10-26 00:00:00 -0300', end_date: '2025-10-26 23:59:59 -0300'
        )

        expect(result[:errors]).to eq(nil)
        expect(result[:journeys].count).to eq(0)
      end
    end
  end
end
