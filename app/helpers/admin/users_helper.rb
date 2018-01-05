require 'rubyvis'
module Admin::UsersHelper
  def some_method
      vis = Rubyvis::Panel.new do
      width 150
      height 150

      bar do
        data [1, 1.2, 1.7, 1.5, 0.7, 0.3]
        width 20
        height {|d| d * 80}
        bottom(0)
        left {index * 25}
        end
      end

      vis.render
      raw vis.to_svg
    end
end
