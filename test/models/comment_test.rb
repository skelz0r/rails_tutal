require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @post = @user.posts.build(content: "Blabla", title: "Title")
    @post.save
    @comment = @user.comments.build(content: "Blabla", post_id: @post.id)
  end

  test "should be valid" do
    assert @comment.valid?
  end

  should validate_presence_of(:content)
  should validate_presence_of(:post)
  should validate_presence_of(:user)

  should belong_to(:post)
  should belong_to(:user)

end
