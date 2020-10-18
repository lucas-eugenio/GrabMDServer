# frozen_string_literal: true

# Models/Company
class Company < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :cnpj, presence: true, uniqueness: true

  validate :cnpj_format

  private

  def cnpj_format
    errors.add(:cnpj, 'Wrong Format') unless
      cnpj.match(%r{\A\d{2}\.\d{3}\.\d{3}\/\d{4}\-\d{2}\z})
  end
end
