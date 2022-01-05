# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post, public: true

    return unless user.present?  # additional permissions for logged in users (they can read their own posts)
    can :read, Post, user: user
  end
end
