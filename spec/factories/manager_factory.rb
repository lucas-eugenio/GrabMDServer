# frozen_string_literal: true

FactoryBot.define do
  factory :manager do
    name { 'First Manager' }
    email { 'firstmanager@email.com' }
    cpf { '156.535.950-04' }
    password { '123456' }
    company
  end
end
