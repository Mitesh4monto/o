class RegistrationsController < Devise::RegistrationsController
  
  
  protected
  
  def new
    puts '****************************************'    
  end
  
  def create
    puts '****************************************'    
  end


  def after_sign_in_path_for(resource)
    puts '****************************************[[[[[[[]]]]]]]b'    
  end

  def after_sign_out_path_for(resource)
    puts '****************************************[[[[[[[]]]]]]]e'
    '/courses'
  end

  def after_sign_up_path_for(resource)
    puts '****************************************[[[[[[[]]]]]]]fs'
      post_register(resource)    
    '/courses'
  end
  
  def after_inactive_sign_up_path_for(resource)
    puts '****************************************[[[[[[[]]]]]]]wer'
    post_register(resource)    
    '/courses'
  end
  
end