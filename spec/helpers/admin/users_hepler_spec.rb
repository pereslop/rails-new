require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the Account::UsersHelper. For example:
#
# describe Account::UsersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe Admin::UsersHelper, type: :helper do
  include RSpecHtmlMatchers
  let!(:user) { FactoryGirl.create(:user) }



  it 'comments graph have svg' do
    FactoryGirl.create_list(:comment, 5, user_id: user.id)
    expect(comments_graph(user.comments)).to have_tag('svg')
  end
end
