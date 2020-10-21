# frozen_string_literal: true

module Mutations
  # GraphQL/Mutations/CreateJourney
  class CreateJourney < BaseMutation
    # Required Arguments
    argument :token, String, required: true
    argument :name, String, required: true
    argument :date, String, required: true
    argument :payment_date, String, required: true
    argument :wage, Float, required: true
    argument :address, String, required: true

    # Optional Arguments
    argument :payment_method, Types::PaymentMethodType, required: false
    argument :provides_ppe, Boolean, required: false
    argument :hire_entity, Types::HireEntityType, required: false

    field :journey, Types::JourneyType, null: true
    field :errors, String, null: true

    def resolve(
      token: nil, name: nil, date: nil, payment_date: nil, wage: nil, address: nil,
      payment_method: nil, provides_ppe: nil, hire_entity: nil
    )
      user = current_user(token)
      return { errors: 'Token Incorreto' } unless user
      return { errors: 'Não Autorizado' } unless user.can? :create_journey

      company = user.company
      journey = create_journey(
        company, name, date, payment_date, wage, address, payment_method, provides_ppe, hire_entity
      )
      { journey: journey }
    end

    private

    def create_journey(
      company, name, date, payment_date, wage, address, payment_method, provides_ppe, hire_entity
    )
      Journey.create!(
        name: name, date: date, payment_date: payment_date, wage: wage, address: address,
        payment_method: payment_method, provides_ppe: provides_ppe, hire_entity: hire_entity,
        company: company
      )
    end
  end
end
