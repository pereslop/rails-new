require 'user_statistic'
require 'rubyvis'
module Account::UsersHelper
  include Statistic::UserStatistic

  MARGIN = { top: 5, left: 30, bottom: 35, right: 0 }
  HEIGHT = 170
  LINE_CHART_WIDTH = 300
  BOTTOM_LABEL = -3
  DOT_BOTTOM = -25
  DOT_LABEL_BOTTOM = -30
  DOT_LEFT = 150
  DAYS_COUNT = 7
  COLORS = { read: '#83c9e9', unread: '#5096b6' }
  CHART_LINE_COLOR = '#dfdfdf'
  DEFAULT_MAX_VALUE = 10
  DAY_START = -1
  BAR_CHART_WIDTH = 400


  def line_chart(user)
    message_statistic = MessageStatistic.new(user)
    data = message_statistic.data_for_graph
    days = last_days

    colors = pv.colors(COLORS[:read], COLORS[:unread])
    legend = ['read messages', 'unread messages']

    i = DAY_START

    x = pv.Scale.linear(0, [DEFAULT_MAX_VALUE, data.flatten.max].max).range(0, HEIGHT)
    y = pv.Scale.ordinal(pv.range(DAYS_COUNT)).split_banded(0, BAR_CHART_WIDTH, 4/5)

    panel = Rubyvis::Panel.new do
      width  BAR_CHART_WIDTH
      height HEIGHT
      bottom MARGIN[:bottom]
      left   MARGIN[:left]

      panel do
        data data
        left lambda { y.scale(self.index) - MARGIN[:left] - MARGIN[:right] }
        width y.range().first

        bar do
          data lambda { |d| d }
          left lambda { self.index * y.range().first / 2 + 1 unless self.index.zero? }
          width y.range().first / 1.5
          bottom 0
          height x
          fillStyle lambda { colors.scale(pv.index) }
        end

        label do
          right 5
          bottom BOTTOM_LABEL
          textAlign 'center'
          textBaseline 'top'
          text lambda { i += 1; days[i].strftime('%A').first(1) }
        end
      end
    end
    panel.render
    panel.to_svg
  end
    def png(svg)
      img, data = Magick::Image.from_blob(svg) do
        self.format = 'SVG'
      end
      img.to_blob {self.format = 'PNG'}
    end
end
