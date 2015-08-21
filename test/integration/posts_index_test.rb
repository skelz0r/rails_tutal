require 'test_helper'

class PostsIndexTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @post = posts(:one)
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
    assert_select "li.post", Post.count
  end

end
