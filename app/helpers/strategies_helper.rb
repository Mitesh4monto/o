module StrategiesHelper

  def shorten(text, length)
    text.split(" ").each_with_object("") {|x,ob| break ob unless (ob.length + " ".length + x.length <= length);ob << (" " + x)}.strip
  end
end
