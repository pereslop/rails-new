require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
    let!(:user) { FactoryGirl.create(:user) }
  describe 'statistic' do
    let!(:comment) { FactoryGirl.create(:comment, user_id: user.id)}
    let!(:mail) { UserMailer.statistic(user, user.comments) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Statistic')
      expect(mail.to).to eq([user.email])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('statistic')
    end
  end

  describe 'messages_statistic' do
    let! (:conversation) { Conversation.create() }
    let! (:recipient) { FactoryGirl.create(:user) }
    let! (:message) do
      FactoryGirl.create(:message, conversation_id: conversation.id, user_id: user.id)
    end
    let!(:message_statistic_mail) { UserMailer.statistic(user, user.comments) }

    it 'render the headers' do
      expect(message_statistic_mail.subject).to eq('Messenger activity')
    end

  end
end
