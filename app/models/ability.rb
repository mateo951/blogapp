# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    can :read, :all

    if user.present?
      can :read, :all
      can :manage, Post, user: user
    end
  end
end
