# frozen_string_literal: true

# Models/Doctor
class Doctor < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :crm, presence: true, uniqueness: true

  validate :crm_format

  private

  def crm_format
    errors.add(:crm, 'Wrong Format') unless crm.match(/\A[1-9]{5}[1-9]?$\z/)
  end
end
