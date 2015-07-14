class Course < ActiveRecord::Base
  # http://easyramble.com/rails-active-record-serialize.html
  # arrayをsaveする
  serialize :blob

end
