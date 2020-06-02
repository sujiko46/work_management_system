class CreateWorktimes < ActiveRecord::Migration[5.2]
  def change
    create_table :worktimes do |t|
      t.integer :year
      t.integer :month
      t.integer :day
      t.datetime :in_time
      t.datetime :out_time
      #外部キー制約：この場合userIDとの整合性がとれることを約束してくれる
      t.references :user, foreign_key: true
    end
  end
end
