# frozen_string_literal: true

require 'rails_helper'

module Mutations
  RSpec.describe AcceptCandidature do
    let(:mutation) { Mutations::AcceptCandidature.new(object: nil, field: nil, context: {}) }
    let(:company) { create(:company) }
    let(:first_doctor) { create(:doctor) }
    let(:second_doctor) { create(:doctor, name: 'Drauzio Var Ella', email: 'drauzio@email.com', crm: '375511') }
    let(:journey) { create(:journey, company: company) }
    let(:candidature) { create(:candidature, journey: journey, doctor: first_doctor) }
    let(:second_candidature) { create(:candidature, journey: journey, doctor: second_doctor) }
    let(:token) { create_token('company', company.id) }

    before do
      create(:candidature, journey: journey, doctor: second_doctor)
    end

    describe 'Cenário 1' do
      it 'Aceita e Atualiza os Status' do
        result = mutation.resolve(token: token, candidature_id: candidature.id)

        expect(result[:errors]).to eq(nil)
        expect(Candidature.find(candidature.id).status).to eq('accepted')
        expect(Candidature.where.not(id: candidature.id).pluck(:status)).to eq(['refused'])
        expect(Journey.first.doctor).to eq(first_doctor)
      end
    end
  end
end
