require 'user_statistic'
module Admin::UsersHelper
  include Statistic::UserStatistic

  def comments_graph(comments)
    require 'rubyvis'
    comments_data = comment_statistic_graph_data(comments)
    days = last_days


#/* Sizing and scales. *
    w = 600
    h = 250
    x = pv.Scale.linear(0, comments_data.max).range(0, w)
    y = pv.Scale.ordinal(pv.range(comments_data.count)).split_banded(0, h, 4/5.0)

#/* The root panel. */
    vis = pv.Panel.new()
              .width(w)
              .height(h)
              .bottom(20)
              .left(60)
              .right(10)
              .top(5);

#/* The bars. */
    bar = vis.add(pv.Bar)
              .data(comments_data)
              .top(lambda { y.scale(self.index)})
              .height(y.range_band)
              .left(0)
              .width(x)

#/* The value label. */
    bar.anchor("right").add(pv.Label)
        .text_style("white")
        .text(lambda { |d| d })

#/* The variable label. */
    bar.anchor("left").add(pv.Label)
        .text_margin(3)
        .text_align("right")
        .text(lambda { days[self.index].strftime('%F') });

#/* X-axis ticks. */
    vis.add(pv.Rule)
        .data(x.ticks(5))
        .left(x)
        .stroke_style(lambda {|d|  d!=0 ? "rgba(255,255,255,.3)" : "#000"})
        .add(pv.Rule)
        .bottom(0)
        .height(5)
        .stroke_style("#000")
        .anchor("bottom").add(pv.Label)
        .text(x.tick_format);

    vis.render();
    vis.to_svg.html_safe
  end

  def png(svg)
    img, data = Magick::Image.from_blob(svg) do
       self.format = 'SVG'
     end
     img.to_blob {self.format = 'PNG'}
  end
end
