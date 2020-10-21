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
end
