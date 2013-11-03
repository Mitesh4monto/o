class OrderedChapter < Chapter
  acts_as_orderable

  amoeba do
    enable
    prepend :title => "Copy of "
  end
  
  
end
