# == Schema Information
# Schema version: 3
#
# Table name: trails
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Trail < ActiveRecord::Base
  belongs_to :user
  has_many :points
end
