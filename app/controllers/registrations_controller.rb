class RegistrationsController < Devise::RegistrationsController
  
  
  protected
  
  def new
    puts '****************************************'    
  end
  
  def create
    puts '****************************************'    
  end

  puts '****************************************[[[[[[[]]]]]]]'


  def after_sign_in_path_for(resource)
    puts '****************************************[[[[[[[]]]]]]]'    
  end

  def after_sign_out_path_for(resource)
    puts '****************************************[[[[[[[]]]]]]]'
  end

  def after_sign_up_path_for(resource)
    puts '****************************************[[[[[[[]]]]]]]'
      post_register(resource)    
      root_path
  end
  
  def after_inactive_sign_up_path_for(resource)
    puts '****************************************[[[[[[[]]]]]]]'
    post_register(resource)    
    root_path
  end
  
end