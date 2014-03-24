class AppSetting < ActiveRecord::Base
  validates_uniqueness_of :name
  
  def self.get(name)
    as = self.find_by_name(name)
    as.value if as
  end
  
  def self.set(name, value)
    result = AppSetting.find_by_name(name)
    if result
      result.value = value      
      result.save
    else
      AppSetting.create!(name: name, value: value)
    end
  end
end
