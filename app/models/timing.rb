class Timing < ActiveRecord::Base
  belongs_to :activity
  attr_accessible :kind_of_timing, :info
  

  amoeba do
    enable
  end


  def print
    puts "kind of timing: #{self.kind_of_timing}, info: #{self.info}"
  end

  
end
