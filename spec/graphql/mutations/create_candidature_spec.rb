# frozen_string_literal: true

require 'rails_helper'

module Mutations
  RSpec.describe CreateCandidature do
    let(:mutation) { Mutations::CreateCandidature.new(object: nil, field: nil, context: {}) }
    let(:doctor) { create(:doctor) }
    let(:token) { create_token('doctor', doctor.id) }
    let(:journey) { create(:journey) }

    describe 'Cenário 1' do
      it 'Cria Inscrição com Sucesso' do
        expect(Candidature.count).to eq(0)

        result = mutation.resolve(token: token, journey_id: journey.id)

        expect(Candidature.count).to eq(1)
        expect(result[:errors]).to eq(nil)
      end
    end
  end
end
