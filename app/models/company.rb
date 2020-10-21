# frozen_string_literal: true

# Models/Company
class Company < ApplicationRecord
  include Authentifiable

  has_many :managers, dependent: :destroy

  validates :cnpj, presence: true, uniqueness: true
  validate :cnpj_format

  def can_create_manager?
    true
  end

  def permissions
    { create_manager: true }
  end

  def can?(permission)
    permissions[permission]
  end

  private

  def cnpj_format
    errors.add(:cnpj, 'Wrong Format') unless
      cnpj.match(%r{\A\d{2}\.\d{3}\.\d{3}\/\d{4}\-\d{2}\z})
  end
end
