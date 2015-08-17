require 'test_helper'

class PostTest < ActiveSupport::TestCase
	def setup
		@post = Post.new(title: "Title", content: "blabla", user_id:1)
	end
	test "should be valid" do
		assert @post.valid?
	end
end
