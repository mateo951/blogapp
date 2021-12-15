5.times do |i|
	user = User.create(name: "User ##{i}", bio: "A bio.")
	5.times do |j|
		post = Post.create(title: "Awesome Post", text: "Lorem Ipsum Dolor Amet", author_id: user.id)
	end
end

