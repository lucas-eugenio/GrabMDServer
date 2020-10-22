# frozen_string_literal: true

# Models/Journey
class Journey < ApplicationRecord
  belongs_to :company
  belongs_to :doctor, optional: true

  enum payment_method: {
    account_debit: 'account_debit'
  }

  enum hire_entity: {
    individual: 'individual',
    legal: 'legal',
    both: 'both'
  }

  validates :name, presence: true
  validates :date, presence: true
  validates :payment_date, presence: true
  validates :wage, presence: true
  validates :address, presence: true

  scope :with_date_after, ->(date) { where('date > ?', date) if date.present? }
  scope :with_date_before, ->(date) { where('date < ?', date) if date.present? }
  scope :with_payment_date_after, ->(date) { where('payment_date > ?', date) if date.present? }
  scope :with_payment_date_before, ->(date) { where('payment_date < ?', date) if date.present? }
  scope :with_wage_bigger_than, ->(wage) { where('wage > ?', wage) if wage.present? }
  scope :with_address, ->(address) { where('address LIKE ?', "%#{address}%") if address.present? }
  scope :with_payment_method, ->(method) { where(payment_method: method) if method.present? }
  scope :that_hires, ->(entity) { where(hire_entity: entity) if entity.present? }
  scope :that_provides_ppe, ->(provides) { where(provides_ppe: provides) if provides.present? }
end
