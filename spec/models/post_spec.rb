# == Schema Information
#
# Table name: posts
#
#  id           :integer          not null, primary key
#  content      :text
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  picture      :string
#  likers_count :integer          default(0)
#  likees_count :integer          default(0)
#

require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'validations' do
    it { FactoryGirl.build(:post).should be_valid }
  end