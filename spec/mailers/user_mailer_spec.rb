require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "statistic" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:comment) { FactoryGirl.create(:comment, user_id: user.id)}
    let!(:mail) { UserMailer.statistic(user, user.comments) }

    it "renders the headers" do
      expect(mail.subject).to eq("Statistic")
      expect(mail.to).to eq([user.email])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match('statistic')
    end
  end
end
