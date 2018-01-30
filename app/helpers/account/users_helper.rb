require 'user_statistic'
require 'rubyvis'
module Account::UsersHelper
  include Statistic::UserStatistic

  MARGIN = { top: 5, left: 30, bottom: 35, right: 0 }
  HEIGHT = 120
  LINE_CHART_WIDTH = 300
  BOTTOM_LABEL = -3
  DOT_BOTTOM = -25
  DOT_LABEL_BOTTOM = -30
  DOT_LEFT = 150
  # DAYS = last_days
  DAYS_COUNT = 7
  DAY_START = -1
  COLORS = { files_scanned: '#83c9e9', ips_scanned: '#5096b6', connectors: '#14a792', unseen_connectors: '#e3edff' }
  CHART_LINE_COLOR = '#dfdfdf'
  DEFAULT_MAX_VALUE = 10

  def line_chart(user)
    message_statistic = MessageStatistic.new(user)
    data = message_statistic.data_for_graph
    days = last_days

    colors = [COLORS[:files_scanned], COLORS[:ips_scanned]]
    legend = ['read messages', 'unread messages']

    x = pv.Scale.linear(0, DAYS_COUNT - 1).range(0, LINE_CHART_WIDTH)
    y = pv.Scale.linear(0, [DEFAULT_MAX_VALUE, data.flatten.max].max).range(0, HEIGHT)

    panel = Rubyvis::Panel.new do
      width  LINE_CHART_WIDTH
      height HEIGHT
      bottom MARGIN[:bottom]
      left   MARGIN[:left]
      right  MARGIN[:right]
      top    MARGIN[:top]

      rule do
        data { y.ticks(5) }
        left 0
        right 0
        bottom y
        strokeStyle CHART_LINE_COLOR

        label do
          textAlign 'right'
          textBaseline 'middle'
          text y.tick_format
        end
      end

      data.transpose.each_with_index do |row, i|
        line do
          data row
          left lambda { x.scale(self.index) }
          bottom lambda { |d| y.scale(d) }
          lineWidth 1
          strokeStyle colors[i]
        end

        dot do
          shape 'square'
          fillStyle colors[i]
          strokeStyle colors[i]
          bottom DOT_BOTTOM
          left DOT_LEFT * i + 5

          label do
            bottom DOT_LABEL_BOTTOM
            textBaseline 'center'
            left DOT_LEFT * i + 10
            text legend[i]
          end
        end
      end

      rule do
        bottom 0

        label do
          bottom BOTTOM_LABEL
          textAlign 'center'
          textBaseline 'top'
          text(lambda { days[self.index].strftime('%F') })
        end
      end

      rule do
        left 0
      end
    end

    panel.render
    panel.to_svg
  end
end
