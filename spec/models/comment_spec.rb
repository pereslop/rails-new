# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  content          :text
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  commentable_type :string
#  commentable_id   :integer
#

require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'validations' do
    it { FactoryGirl.build(:comment).should be_valid }
  end
  context 'queries' do
    it 'returns count of comments for one day' do
      FactoryGirl.create(:comment)
      expect(Comment.count_per_day(Time.zone.now)).to eq(1)
    end
  end
end
