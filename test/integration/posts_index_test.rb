require 'test_helper'

class PostsIndexTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @post = @user.posts.build(title: "Sacha", content: "Sacha")
    @post.save
  end

  test "correct templates" do
    get  '/index'
    assert_template 'posts/index'
    assert_select "title", full_title("All Posts")
    assert_select "h1", "All Posts"
    assert_select "h1", 1
  end

  test "number of posts" do
    get  '/index'
    assert_select ".post_content", Post.count
  end

end
