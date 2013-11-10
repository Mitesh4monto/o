class MainChapter < Chapter  

  amoeba do
    enable
    prepend :title => "Copy of "
  end
  
  def print
    puts "title: #{self.title}"
    puts "activities:"
    self.activities.each { |activity| puts activity.title }    
  end
  
end
