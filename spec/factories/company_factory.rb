# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    name { 'Hospital do Coração' }
    email { 'hospitalcoração@email.com' }
    cnpj { '63.733.327/0001-92' }
    password { '123456' }
  end
end
