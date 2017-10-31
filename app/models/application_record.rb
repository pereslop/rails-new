class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.next_for(obj)
    obj.prev
  end

  def self.prev_for(obj)
    obj.next
  end

  def next
    self.class.where("id > ?", id).last
  end

  def prev
    self.class.where("id < ?", id).first
  end
end
