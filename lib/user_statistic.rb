module Statistic
  module UserStatistic
    DAYS_IN_WEEK = 7

    def last_days
      (1..7).to_a.map { |i| i.days.ago }.reverse
    end

    def comment_statistic_graph_data(user_comments)
      data = []
      days = last_days
      days.each  do |day|
        data << user_comments.count_per_day(day)
      end
      data
    end
  end
end
