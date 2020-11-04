# frozen_string_literal: true

FactoryBot.define do
  factory :candidature do
    doctor
    journey
    status { 'in_progress' }
  end
end
