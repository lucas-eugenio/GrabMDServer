# frozen_string_literal: true

require 'rails_helper'

module Resolvers
  RSpec.describe JourneyCandidaturesResolver do
    let(:resolver) { Resolvers::JourneyCandidaturesResolver.new(object: nil, field: nil, context: {}) }
    let(:company) { create(:company) }
    let(:first_doctor) { create(:doctor) }
    let(:second_doctor) { create(:doctor, name: 'Drauzio Var Ella', email: 'drauzio@email.com', crm: '375511') }
    let(:first_journey) { create(:journey, company: company) }
    let(:second_journey) do
      create(:journey, name: 'Plantão Hospital do Coração', company: company, date: '2020-10-28 12:00:00 -0300')
    end
    let(:token) { create_token('company', company.id) }

    before do
      create(:candidature, journey: first_journey, doctor: first_doctor)
      create(:candidature, journey: first_journey, doctor: second_doctor)
    end

    describe 'Cenário 1' do
      it 'Encontro as Duas Candidaturas' do
        result = resolver.resolve(token: token, journey_id: first_journey.id)

        expect(result[:errors]).to eq(nil)
        expect(result[:candidatures].count).to eq(2)
        expect(result[:candidatures]).to include(Candidature.first)
        expect(result[:candidatures]).to include(Candidature.second)
      end
    end

    describe 'Cenário 2' do
      it 'Não Encontro Candidaturas' do
        result = resolver.resolve(token: token, journey_id: second_journey.id)

        expect(result[:errors]).to eq(nil)
        expect(result[:candidatures].count).to eq(0)
      end
    end
  end
end
