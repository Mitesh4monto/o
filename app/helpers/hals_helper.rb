module HalsHelper
  
  def visiblity_text(hal)
    "Private" if privacy == 0
    "Public" if privacy == 1
  end
  
  
end
