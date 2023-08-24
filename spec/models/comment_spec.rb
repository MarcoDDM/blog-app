require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:tom) { User.create(name: 'Tom', posts_counter: 0) }
  let(:post) { Post.create(title: 'Title', comments_counter: 0, likes_counter: 0, author: tom) }

end
