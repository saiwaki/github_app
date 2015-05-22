class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.text :diff
      t.text :blob
      t.string :summary
      t.text :description
      t.string :user
      t.string :repo
      t.string :sha

      t.timestamps null: false
    end
  end
end
