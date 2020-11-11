# frozen_string_literal: true

# Models/Doctor
class Doctor < ApplicationRecord
  include Authentifiable

  has_many :jorneys, dependent: :destroy
  has_many :candidatures, dependent: :destroy

  validates :crm, presence: true, uniqueness: true
  validate :crm_format

  def permissions
    { find_journeys: true, create_candidature: true, my_candidatures: true, update_doctor_profile: true,
      my_profile: true, company_profile: true }
  end

  def can?(permission)
    permissions[permission]
  end

  private

  def crm_format
    errors.add(:crm, 'Wrong Format') unless crm.match(/\A\d{5}\d?\z/)
  end
end
