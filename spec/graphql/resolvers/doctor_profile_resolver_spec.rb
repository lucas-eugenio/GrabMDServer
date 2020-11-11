# frozen_string_literal: true

require 'rails_helper'

module Resolvers
  RSpec.describe DoctorProfileResolver do
    let(:mutation) { Resolvers::DoctorProfileResolver.new(object: nil, field: nil, context: {}) }
    let(:doctor) { create(:doctor) }
    let(:company) { create(:company) }
    let(:company_token) { create_token('company', company.id) }
    let(:manager) { create(:manager, company: company) }
    let(:manager_token) { create_token('manager', manager.id) }

    describe 'Cenário 1' do
      it 'Mostra o Perfil do Médico' do
        result = mutation.resolve(token: company_token, doctor_id: doctor.id)

        expect(result[:errors]).to eq(nil)
        expect(result[:doctor].present?).to eq(true)
        expect(result[:doctor][:id]).to eq(doctor.id)
      end
    end

    describe 'Cenário 2' do
      it 'Mostra o Perfil do Médico' do
        result = mutation.resolve(token: manager_token, doctor_id: doctor.id)

        expect(result[:errors]).to eq(nil)
        expect(result[:doctor].present?).to eq(true)
        expect(result[:doctor][:id]).to eq(doctor.id)
      end
    end
  end
end
