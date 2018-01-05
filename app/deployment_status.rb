module DynamicReports
 module DeploymentStatusDiagram
  MARGIN = { left: 0, bottom: 30, right: 10 }
  HEIGHT = 120
  LINE_CHART_WIDTH = 310
  BAR_CHART_WIDTH = 120
  BOTTOM_LABEL = -3
  DOT_BOTTOM = -25
  DOT_LABEL_BOTTOM = -30
  DOT_LEFT = 150
  DAYS = ['M', 'T', 'W', 'T', 'F', 'S', 'S']
  DAY_START = -1

  def line_chart(data)
   colors = ["purple", "steelblue"]
   legend = [I18n.t('dynamic_reports.deployment_status.metrics.files_scanned'), I18n.t('dynamic_reports.deployment_status.metrics.ips_scanned')]

   x = pv.Scale.linear(0, data.first.length - 1).range(0, LINE_CHART_WIDTH)
   y = pv.Scale.linear(0, data.flatten.max).range(0, HEIGHT)

   panel = Rubyvis::Panel.new do
    width LINE_CHART_WIDTH
    height HEIGHT
    bottom MARGIN[:bottom]
    left MARGIN[:left]
    right MARGIN[:right]

    data.each_with_index do |row, i|
     line do
      data row
      left lambda { x.scale(self.index) }
      bottom lambda { |d| y.scale(d) }
      lineWidth 1
      strokeStyle colors[i]
     end

     dot do
      shape 'square'
      fillStyle colors.reverse[i]
      strokeStyle colors.reverse[i]
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
      text ApplicationController.helpers.time_ago_in_words(data.first.length.days.ago)
     end
    end

    rule do
     left 0
    end
   end

   panel.render
   panel.to_svg
  end

  def area_chart(data)
   colors = ["#dfdfdf", "#6cc04a"]
   legend = [I18n.t('dynamic_reports.deployment_status.metrics.connectors'), I18n.t('dynamic_reports.deployment_status.metrics.unseen_connectors')]

   x = pv.Scale.linear(0, data.first.length - 1).range(0, LINE_CHART_WIDTH)
   y = pv.Scale.linear(0, data.flatten.max).range(0, HEIGHT)

   panel = Rubyvis::Panel.new do
    width LINE_CHART_WIDTH
    height HEIGHT
    bottom MARGIN[:bottom]
    left MARGIN[:left]
    right MARGIN[:right]

    data.each_with_index do |row, i|
     area do
      data row
      bottom 0
      left lambda { x.scale(self.index) }
      height lambda { |d| y.scale(d) }
      fillStyle colors[i]
     end

     dot do
      shape 'square'
      fillStyle colors.reverse[i]
      strokeStyle colors.reverse[i]
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

    label do
     bottom BOTTOM_LABEL
     textAlign 'center'
     textBaseline 'top'
     text ApplicationController.helpers.time_ago_in_words(data.first.length.days.ago)
    end
   end

   panel.render
   panel.to_svg
  end

  def grouped_bar_chart(data)
   colors = pv.colors("steelblue", "purple")
   i = -1

   x = pv.Scale.linear(0, [1, data.flatten.max].max).range(0, HEIGHT)
   y = pv.Scale.ordinal(pv.range(data.length)).split_banded(0, HEIGHT, 4/5)

   panel = Rubyvis::Panel.new do
    width BAR_CHART_WIDTH
    height HEIGHT
    bottom MARGIN[:bottom]

    panel do
     data data
     left lambda { y.scale(self.index) - MARGIN[:left] - MARGIN[:right] }
     width y.range().first

     bar do
      data lambda { |d| d }
      left lambda { self.index * y.range().first / 2 + 1 unless self.index.zero? }
      width y.range().first / 2
      bottom 0
      height x
      fillStyle lambda { colors.scale(pv.index) }
     end

     label do
      right 5
      bottom BOTTOM_LABEL
      textAlign 'center'
      textBaseline 'top'
      text lambda { i += 1; DAYS[i] }
     end
    end
   end
   panel.render
   panel.to_svg
  end

  def stacked_bar_chart(data)
   colors = pv.colors("#dfdfdf", "#6cc04a")

   data = data.map { |e| [e.first.try(:+, e.last), e.first].compact }
   i = DAY_START

   x = pv.Scale.linear(0, [1, data.flatten.max].max).range(0, HEIGHT)
   y = pv.Scale.ordinal(pv.range(data.length)).split_banded(0, HEIGHT, 4/5)

   panel = Rubyvis::Panel.new do
    width BAR_CHART_WIDTH
    height HEIGHT
    bottom MARGIN[:bottom]

    panel do
     data data
     left lambda { y.scale(self.index) - MARGIN[:left] - MARGIN[:right] }
     width y.range().first

     bar do
      data lambda { |d| d }
      width y.range().first - 4
      bottom 0
      height x
      fillStyle lambda { colors.scale(pv.index) }
     end

     label do
      bottom BOTTOM_LABEL
      textAlign 'center'
      textBaseline 'top'
      text lambda { i += 1; DAYS[i] }
     end
    end
   end

   panel.render
   panel.to_svg
  end
 end
end
