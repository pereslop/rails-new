module Statistic
  module UserStatistic
    DAYS_IN_WEEK = 0..6

    def last_days
      DAYS_IN_WEEK.to_a.map { |i| i.days.ago }.reverse
    end

    def comment_statistic_graph_data(user_comments)
      last_days.map { |day|  user_comments.count_per_day(day) }
    end
  end
end
