# frozen_string_literal: true

# Models/Candidature
class Candidature < ApplicationRecord
  belongs_to :doctor
  belongs_to :journey

  enum status: {
    in_progress: 'in_progress',
    accepted: 'accepted',
    refused: 'refused'
  }

  validates :status, presence: true

  scope :of_doctor, ->(id) { where(doctor_id: id) }
  scope :of_journey, ->(id) { where(journey_id: id) }
end
