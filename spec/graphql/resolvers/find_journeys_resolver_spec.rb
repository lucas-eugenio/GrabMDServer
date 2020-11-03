# frozen_string_literal: true

require 'rails_helper'

module Resolvers
  RSpec.describe FindJourneysResolver do
    let(:resolver) { Resolvers::FindJourneysResolver.new(object: nil, field: nil, context: {}) }
    let(:company) { create(:company) }

    before do
      create(:journey, company: company)
      create(:journey, name: 'Setor Emergência no H. M. de Barueri', company: company)
      create(:journey, name: 'Setor Observação no H. Paulista', company: company)
      create(:journey, name: 'Plantão no clube XYZ', company: company)
    end

    describe 'Cenário 2' do
      it 'Encontro Todas as Quatro Vagas' do
        doctor = create(:doctor)
        token = create_token('doctor', doctor.id)

        result = resolver.resolve(token: token)

        expect(result[:errors]).to eq(nil)
        expect(result[:journeys].count).to eq(4)
      end
    end
  end
end
