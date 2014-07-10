module ApplicationHelper

  def addcustomjs(files)
    content_for(:head_js) { javascript_include_tag(files) }
  end

  # help tips with question mark image
  def tipper(text, direction = 'bottom')
    image_tag("/images/question_mark_blue.png", 'title' => text, :height => '25')     
  end

  # help tips with question mark image
  def tippertxt(text, direction = 'bottom')
    image_tag("/images/question_mark_blue.png", :class => 'button tipped', 'data-title' => text, 'data-tipper-options' => '{"direction":"' + direction + '"}', :height => '25')     
  end

  def tipper_text(text)
    "&nbsp(<span title='#{text}'>" + link_to('?', '#',:onclick=>"return false;") + "</span>)"
  end

protected

  def after_sign_in_path_for(resource)
    puts '****************************************[[[[[[[]]]]]]]34'    
    '/courses'
  end

  def after_sign_out_path_for(resource)
    puts '****************************************[[[[[[[]]]]]]]25'
    '/courses'
  end

  def after_sign_up_path_for(resource)
    puts '****************************************[[[[[[[]]]]]]]6'
      post_register(resource)    
    '/courses'
  end
  
  def after_inactive_sign_up_path_for(resource)
    puts '****************************************[[[[[[[]]]]]]]16'
    post_register(resource)    
    '/courses'
  end



  
end
