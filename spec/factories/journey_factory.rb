# frozen_string_literal: true

FactoryBot.define do
  factory :journey do
    name { 'Setor Remoção no H. M. de Barueri' }
    date { '2020-10-26 00:00:00 -0300' }
    payment_date { '2020-10-27 00:00:00 -0300' }
    wage { 1500 }
    address { '06463-320' }
    payment_method { 'account_debit' }
    provides_ppe { true }
    hire_entity { 'individual' }
    company
  end
end
