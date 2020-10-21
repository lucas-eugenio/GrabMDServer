# frozen_string_literal: true

# Models/Doctor
class Doctor < ApplicationRecord
  include Authentifiable

  validates :crm, presence: true, uniqueness: true
  validate :crm_format

  def permissions
    {}
  end

  private

  def crm_format
    errors.add(:crm, 'Wrong Format') unless crm.match(/\A\d{5}\d?\z/)
  end
end
