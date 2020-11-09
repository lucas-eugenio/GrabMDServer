# frozen_string_literal: true

require 'rails_helper'

module Mutations
  RSpec.describe UpdateDoctorProfile do
    let(:mutation) { Mutations::UpdateDoctorProfile.new(object: nil, field: nil, context: {}) }
    let(:doctor) { create(:doctor) }
    let(:token) { create_token('doctor', doctor.id) }

    describe 'Cenário 1' do
      it 'Atualiza os Dados do Médico' do
        phone = '+55 11 91234-5678'
        formation = 'Profissional Formation'
        experiences = 'Profissional Experiences'

        result = mutation.resolve(
          token: token,
          phone: phone,
          formation: formation,
          experiences: experiences
        )

        expect(result[:errors]).to eq(nil)
        expect(result[:doctor][:phone]).to eq(phone)
        expect(result[:doctor][:formation]).to eq(formation)
        expect(result[:doctor][:experiences]).to eq(experiences)
      end
    end
  end
end
