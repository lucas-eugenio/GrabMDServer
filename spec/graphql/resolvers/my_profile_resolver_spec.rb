# frozen_string_literal: true

require 'rails_helper'

module Resolvers
  RSpec.describe MyProfileResolver do
    let(:mutation) { Resolvers::MyProfileResolver.new(object: nil, field: nil, context: {}) }
    let(:company) { create(:company) }
    let(:company_token) { create_token('company', company.id) }
    let(:doctor) { create(:doctor) }
    let(:doctor_token) { create_token('doctor', doctor.id) }

    describe 'Cenário 1' do
      it 'Mostra o Perfil do Médico' do
        result = mutation.resolve(token: doctor_token)

        expect(result[:errors]).to eq(nil)
        expect(result[:company]).to eq(nil)
        expect(result[:doctor].present?).to eq(true)
        expect(result[:doctor][:id]).to eq(doctor.id)
      end
    end

    describe 'Cenário 2' do
      it 'Mostra o Perfil da Empresa' do
        result = mutation.resolve(token: company_token)

        expect(result[:errors]).to eq(nil)
        expect(result[:doctor]).to eq(nil)
        expect(result[:company].present?).to eq(true)
        expect(result[:company][:id]).to eq(doctor.id)
      end
    end
  end
end
