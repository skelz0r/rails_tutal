require 'test_helper'

class PostsIndexTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @posts = []
    9.times do
      @posts << Post.create!(title: "title", content: "content", user_id: @user.id)
    end
  end

  test "correct templates" do
    get  '/index'
    assert_template 'posts/index'
    assert_select "title", full_title("All Posts")
    assert_select "h1", "All Posts"
    assert_select "h1", 1
  end

  test "pagination" do
    get  '/index'
    assert_select 'div.pagination'
    assert_select ".post_content", 5
    get  '/index?page=2'
    assert_select ".post_content", 4
    get  '/index?page=3'
    assert_select ".post_content", 0
  end

end
