# frozen_string_literal: true

# Models/Company
class Company < ApplicationRecord
  include Authentifiable

  has_many :managers, dependent: :destroy
  has_many :journeys, dependent: :destroy

  validates :cnpj, presence: true, uniqueness: true
  validate :cnpj_format

  def permissions
    { create_manager: true, create_journey: true, my_managers: true, my_journeys: true, journey_candidatures: true,
      accept_candidature: true, company_profile: true }
  end

  def can?(permission)
    permissions[permission]
  end

  def company
    self
  end

  private

  def cnpj_format
    errors.add(:cnpj, 'Wrong Format') unless
      cnpj.match(%r{\A\d{2}\.\d{3}\.\d{3}\/\d{4}\-\d{2}\z})
  end
end
