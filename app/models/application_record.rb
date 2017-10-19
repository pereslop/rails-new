class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true


  def next
    self.class.where("id > ?", id).first
  end

  def prev
    self.class.where("id < ?", id).last
  end
end
