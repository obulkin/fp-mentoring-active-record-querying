require "rails_helper"

describe "Querying" do
  before do
    SpecHelper.seed_db
  end

  it "has many posts" do
    User.first.posts
  end

  it "has many likes" do
    User.first.likes
  end

  it "has many comments" do
    User.first.comments
  end

  it "collect all of the likes on the posts of a user with email ( domenick.spinka@gmail.com )" do
    result = User.find_by(email: "domenick.spinka@gmail.com").posts.map {|post| post.likes}.flatten

    ###################
    # DO NOT CODE BELOW THIS
    ###################
    answers = [2, 16, 3, 13, 19, 7, 12, 4, 11, 20, 5, 8, 21]

    result.each do |like|
      expect(answers.delete(like.id)).to be_truthy
    end

    expect(answers.empty?).to eq(true)
  end

  it "collect all of the posts alice@gmail.com commented on" do
    result = User.find_by(email: "alice@gmail.com").comments.map {|comment| comment.post}.uniq

    ###################
    # DO NOT CODE BELOW THIS
    ###################
    answers = [1, 3, 2, 4, 6]

    result.each do |post|
      expect(answers.delete(post.id)).to be_truthy
    end

    expect(answers.empty?).to eq(true)
  end

  it "collect all of the users who commented on dorian.breitenberg@gmail.com's posts" do
    result = User.find_by(email: "dorian.breitenberg@gmail.com").posts.map {|post| post.comments}.flatten.map {|comment| comment.user}.uniq

    ###################
    # DO NOT CODE BELOW THIS
    ###################
    answers = [2, 4]

    result.each do |user|
      expect(answers.delete(user.id)).to be_truthy
    end

    expect(answers.empty?).to eq(true)
  end

  it "collect posts with more than 2 likes" do
    result = Post.all.map {|post| post if post.likes.count > 2}.compact

    ###################
    # DO NOT CODE BELOW THIS
    ###################

    answers = [9, 8]

    result.each do |post|
      expect(answers.delete(post.id)).to be_truthy
    end

    expect(answers.empty?).to eq(true)
  end

  it "create a like record by alice@gmail.com on any one of edd@gmail.com's post" do
    Like.create(post_id: User.find_by(email: "edd@gmail.com").posts.first.id, user_id: User.find_by(email: "alice@gmail.com").id)

    ###################
    # DO NOT CODE BELOW THIS
    ##################
    alice = User.find_by(email: "alice@gmail.com")

    answer = User.find_by(email: "edd@gmail.com").posts.select do |post|
      post.likes.where(user_id: alice.id).first
    end

    expect(answer.empty?).to be_falsey
  end

  it "Return a post commented by domenick.spinka@gmail.com and liked by dorian.breitenberg@gmail.com" do
    # Your query goes here. You can assign variable etc until you find the post you need.
    result = (User.find_by(email: "domenick.spinka@gmail.com").comments.map {|comment| comment.post} & User.find_by(email: "dorian.breitenberg@gmail.com").likes.map {|like| like.post}).first

    ###################
    # DO NOT CODE BELOW THIS
    ##################

    expect(result).to be_instance_of(Post)
    expect(result.id).to equal(6)

  end

end