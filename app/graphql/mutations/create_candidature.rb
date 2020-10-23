# frozen_string_literal: true

module Mutations
  # GraphQL/Mutations/CreateCandidature
  class CreateCandidature < BaseMutation
    argument :token, String, required: true
    argument :journey_id, ID, required: true

    field :candidature, Types::CandidatureType, null: true
    field :errors, String, null: true

    def resolve(token: nil, journey_id: nil)
      doctor = current_user(token)
      return { errors: 'Token Incorreto' } unless doctor
      return { errors: 'Não Autorizado' } unless doctor.can? :create_candidature

      journey = Journey.find_by_id(journey_id)
      return { errors: 'Vaga Incorreta' } unless journey
      return { errors: 'Vaga já Preenchida' } if journey.doctor?
      return { errors: 'Você já se Inscreveu' } if already_created?(doctor, journey)

      candidature = create_candidature(doctor, journey)
      { candidature: candidature }
    end

    private

    def create_candidature(doctor, journey)
      Candidature.create!(
        doctor: doctor,
        journey: journey,
        status: 'in_progress'
      )
    end

    def already_created?(doctor, journey)
      Candidature.where(doctor: doctor, journey: journey).count.positive?
    end
  end
end
