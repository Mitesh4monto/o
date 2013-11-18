class Contact < ActiveRecord::Base

def name
  [firstname,lastname].join " "
end

end
