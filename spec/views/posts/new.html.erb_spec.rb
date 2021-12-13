require 'rails_helper'

RSpec.describe "posts/new", type: :view do
  before(:each) do
    assign(:post, Post.new(
      title: "MyString",
      text: "MyText",
      comments_counter: 1,
      likes_counter: 1
    ))
  end

  it "renders new post form" do
    render

    assert_select "form[action=?][method=?]", posts_path, "post" do

      assert_select "input#post_title[name=?]", "post[title]"

      assert_select "textarea#post_text[name=?]", "post[text]"

      assert_select "input#post_comments_counter[name=?]", "post[comments_counter]"

      assert_select "input#post_likes_counter[name=?]", "post[likes_counter]"
    end
  end
end
