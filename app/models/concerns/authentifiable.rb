# frozen_string_literal: true

# Models/Concerns/Authentifiable
module Authentifiable
  extend ActiveSupport::Concern

  included do
    has_secure_password
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
  end

  def can_create_manager?
    false
  end
end
