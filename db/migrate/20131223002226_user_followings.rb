class UserFollowings < ActiveRecord::Migration
  def change
    create_table "user_followings", :force => true, :id => false do |t|
      t.integer "user_a_id", :null => false
      t.integer "user_b_id", :null => false
    end
  end
end
