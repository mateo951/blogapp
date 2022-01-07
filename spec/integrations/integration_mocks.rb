require 'user'

module Mocks
  def create_users
    names = [
      { name: 'Mateo', bio: "I'm the last oracle", posts_counter: 0, email: 'foo1@foo.com', role: 'admin' },
      { name: 'Felipe', bio: "I'm the First oracle", posts_counter: 0, email: 'foo2@foo.com', role: 'admin' },
    ]
    (0..1).each do |i|
      user = User.new(names[i])
      user.password = 'admin123'
      user.password_confirmation = 'admin123'
      user.save
    end
  
    User.all
  end
end