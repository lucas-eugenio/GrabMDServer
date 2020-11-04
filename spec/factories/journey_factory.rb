# frozen_string_literal: true

FactoryBot.define do
  factory :journey do
    name { 'Setor Remoção no Hospital do Coração' }
    date { '2020-10-26 12:00:00 -0300' }
    payment_date { '2020-10-27 12:00:00 -0300' }
    wage { 1500 }
    address { '04649-000' }
    payment_method { 'account_debit' }
    provides_ppe { false }
    hire_entity { 'individual' }
    company
  end
end
