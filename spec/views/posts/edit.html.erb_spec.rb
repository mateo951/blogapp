require 'rails_helper'

RSpec.describe "posts/edit", type: :view do
  before(:each) do
    @post = assign(:post, Post.create!(
      title: "MyString",
      text: "MyText",
      comments_counter: 1,
      likes_counter: 1
    ))
  end

  it "renders the edit post form" do
    render

    assert_select "form[action=?][method=?]", post_path(@post), "post" do

      assert_select "input#post_title[name=?]", "post[title]"

      assert_select "textarea#post_text[name=?]", "post[text]"

      assert_select "input#post_comments_counter[name=?]", "post[comments_counter]"

      assert_select "input#post_likes_counter[name=?]", "post[likes_counter]"
    end
  end
end
