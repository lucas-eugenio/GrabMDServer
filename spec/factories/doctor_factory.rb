# frozen_string_literal: true

FactoryBot.define do
  factory :doctor do
    name { 'Raphael Muzy' }
    email { 'raphaelmuzy@email.com' }
    crm { '115573' }
    password { '123456' }
  end
end
