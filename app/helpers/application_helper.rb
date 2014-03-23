module ApplicationHelper

  def addcustomjs(files)
    content_for(:head_js) { javascript_include_tag(files) }
  end

  # help tips with question mark image
  def tipper(text, direction = 'bottom')
    image_tag("/images/question_mark_blue.png", :class => 'button tipped', 'data-title' => text, 'data-tipper-options' => '{"direction":"' + direction + '"}', :height => '25')     
  end

  # help tips with question mark image
  def tippertxt(text, direction = 'bottom')
    image_tag("/images/question_mark_blue.png", :class => 'button tipped', 'data-title' => text, 'data-tipper-options' => '{"direction":"' + direction + '"}', :height => '25')     
  end
  
end
