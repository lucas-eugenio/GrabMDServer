# frozen_string_literal: true

module Mutations
  # GraphQL/Mutations/AcceptCandidature
  class AcceptCandidature < BaseMutation
    argument :token, String, required: true
    argument :candidature_id, ID, required: true

    field :errors, String, null: true

    def resolve(token: nil, candidature_id: nil)
      user = current_user(token)
      return { errors: 'Token Incorreto' } unless user
      return { errors: 'Não Autorizado' } unless user.can? :accept_candidature

      candidature = Candidature.find_by_id(candidature_id)
      return { errors: 'Candidatura Não Existe' } unless candidature.present?
      return { errors: 'Não Autorizado' } unless candidature.journey.company_id == user.company.id
      return { errors: 'Plantão Já Possui Médico' } if candidature.journey.doctor.present?

      accept_candidature(candidature)
      update_status(candidature)
      { errors: nil }
    end

    private

    def accept_candidature(candidature)
      doctor = candidature.doctor
      candidature.journey.update(doctor: doctor)
      candidature.update(status: 'accepted')
    end

    def update_status(candidature)
      Candidature.where(journey: candidature.journey).where.not(doctor: candidature.doctor).update(status: 'refused')
    end
  end
end
