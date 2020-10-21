# frozen_string_literal: true

module Types
  # List of All GraphQL/Mutations
  class MutationType < Types::BaseObject
    # Company
    field :create_company, mutation: Mutations::CreateCompany
    field :sign_in_company, mutation: Mutations::SignInCompany
    # Doctor
    field :create_doctor, mutation: Mutations::CreateDoctor
    field :sign_in_doctor, mutation: Mutations::SignInDoctor
    # Manager
    field :create_manager, mutation: Mutations::CreateManager
    field :sign_in_manager, mutation: Mutations::SignInManager
  end
end