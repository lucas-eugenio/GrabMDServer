# frozen_string_literal: true

require 'rails_helper'

module Resolvers
  RSpec.describe MyCandidaturesResolver do
    let(:resolver) { Resolvers::MyCandidaturesResolver.new(object: nil, field: nil, context: {}) }
    let(:company) { create(:company) }
    let(:doctor) { create(:doctor) }
    let(:token) { create_token('doctor', doctor.id) }
    let(:first_journey) { create(:journey, company: company) }
    let(:second_journey) { create(:journey, company: company, name: 'Setor Emergência no Hospital Paulista') }

    before do
      create(:candidature, doctor: doctor, journey: first_journey)
      create(:candidature, doctor: doctor, journey: second_journey)
    end

    describe 'Cenário 1' do
      it 'Encontro as Duas Inscições' do
        result = resolver.resolve(token: token)

        expect(result[:errors]).to eq(nil)
        expect(result[:candidatures].count).to eq(2)
        expect(result[:candidatures]).to include(Candidature.find(1))
        expect(result[:candidatures]).to include(Candidature.find(2))
      end
    end
  end
end
