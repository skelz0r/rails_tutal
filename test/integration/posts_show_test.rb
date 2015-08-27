require 'test_helper'

class PostShowTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @post = @user.posts.create(title: "Sacha", content: "Sacha")
  end

  test "when the post author is not log, it display no link to delete" do
    login
    get "/posts/#{@post.id}", to: 'posts#show'

    assert_select "a[href=\"/posts/#{@post.id}\"][data-method=?]", "delete", 0
  end

  test "when the post author is log, it display link to delete" do
    post login_path, session: { email: @user.email,
      password: "password",
      remember_me: 1
    }
    get "/posts/#{@post.id}", to: 'posts#show'

    assert_select "a[href=\"/posts/#{@post.id}\"][data-method=?]", "delete", 1
  end

  test "when the post author click on delete, his post is deleted" do
    post login_path, session: { email: @user.email,
      password: "password",
      remember_me: 1
    }
    get "/posts/#{@post.id}", to: 'posts#show'

    assert_difference 'Post.count', -1 do
      delete post_path
    end
  end

  test "it display correct template" do
    get "/posts/#{@post.id}", to: 'posts#show'

    assert_template 'posts/show'
    assert_select "title", full_title("#{@post.title}")
    assert_select "h1", "#{@post.title}"
    assert_select "h1", 1
    assert_select ".post_content", 1
    assert_select ".comment_content", @post.comments.count
  end

  test "it doesn't display comment form when user is logged out" do
    get '/posts/' + @post.id.to_s, to: 'posts#show'

    assert_select "form", 0
  end

  test "it display comment form when user is logged in" do
    login
    get "/posts/#{@post.id}", to: 'posts#show'

    assert_select "form", 1
  end

  test "when content is blank, it fails to create a comment" do
    login
    get "/posts/#{@post.id}", to: 'posts#show'

    assert failure_to_comment comment: {
      content: "",
      post_id: @post.id
    }
  end

  test "when content is valid, it create a new comment" do
    login
    get '/posts/' + @post.id.to_s, to: 'posts#show'

    assert_difference 'Comment.count', 1 do
      post_via_redirect comments_path, comment: {
        content: "Content",
        post_id: @post.id
      }
    assert_equal flash[:success], "Comment created !!!"
    assert_template 'posts/show'
    end
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

  def failure_to_comment form
    assert_no_difference 'Comment.count' do
      post_via_redirect comments_path, form
    end

    assert_template 'posts/show'
    assert_equal flash[:danger], "Incorrect comment !"
  end

end
