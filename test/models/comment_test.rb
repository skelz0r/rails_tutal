require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @post = @user.posts.create(content: "Blabla", title: "Title")
    @comment = @user.comments.create(content: "Blabla", post_id: @post.id)
  end

  test "should be valid" do
    assert @comment.valid?
  end

  test "should be destroy when the post is destroy" do
    assert_difference 'Comment.count', -1 do
      @post.destroy
    end
  end

  should validate_presence_of(:content)
  should validate_presence_of(:post)
  should validate_presence_of(:user)

  should belong_to(:post)
  should belong_to(:user)

end
