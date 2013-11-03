class Timing < ActiveRecord::Base
  belongs_to :activity

  amoeba do
    enable
  end
  
end
