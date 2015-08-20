require 'test_helper'

class PostsNewTest < ActionDispatch::IntegrationTest

  test "when data are valid, it creates a new post in database" do
    login
    get new_post_path

    assert_difference 'Post.count', 1 do
      fill_a_valid_post
    end
  end

  test "when data are valid, it show a flash success message" do
    login
    get new_post_path

    fill_a_valid_post
    assert_equal flash[:success], "Post created !!!"
  end

  test "when user is log, display template" do
    login
    get new_post_path

    assert_template 'posts/new'
  end

  test "when form is blank, it fails to create a post" do
    login
    get new_post_path

    assert failure_to_post post: {
      title:  "",
      content: ""
    }
  end

  test "when title is blank, it fails to create a post" do
    login
    get new_post_path

    assert failure_to_post post: {
      title:  "",
      content: "content"
    }
  end

  test "when content is blank, it fails to create a post" do
    login
    get new_post_path

    assert failure_to_post post: {
      title:  "Title",
      content: ""
    }
  end

  test "redirection when the user is not logged in" do
    get new_post_path

    assert_redirected_to login_url
  end

  test "show a flash danger message when the user is not logged in" do
    get new_post_path

    assert_equal flash[:danger], "Please log in first !"
  end

  private

  def login
    get signup_path
    post_via_redirect users_path, user: {
      name:  "Example User",
      email: "user@example.com",
      password: "password",
      password_confirmation: "password"
    }
  end

  def fill_a_valid_post
    post_via_redirect posts_path, post: {
      title:  "Titre",
      content: "content"
    }
  end

  def failure_to_post form
    assert_no_difference 'Post.count' do
      post_via_redirect posts_path, form
    end
    assert_template 'posts/new'
  end

end
