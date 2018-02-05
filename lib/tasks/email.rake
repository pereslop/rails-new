namespace :email do
  desc "messages report"
  task messages_report: :environment do
    User.all.each { |user| UserMailer.messages_statistic(user).deliver  }
  end
end