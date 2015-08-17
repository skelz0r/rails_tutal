require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @post = @user.posts.build(content: "Blabla")
  end

  test "should be valid" do
    assert @post.valid?
  end

  should validate_presence_of(:user)

  should belong_to(:user)
end