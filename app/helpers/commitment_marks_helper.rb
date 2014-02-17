module CommitmentMarksHelper
  def convert_string_to_hex(string_to_convert)
    fixnum_max = (2**(0.size * 8 -2) -1)
    fixnum_min = -(2**(0.size * 8 -2))
    str_hash = string_to_convert.hash
    logger.info("string hash: #{str_hash}")
    ratio = (str_hash - fixnum_min).to_f / (fixnum_max - fixnum_min)
    max_color_hex = 'ffffff'.to_i(16)
    hexed = ratio * max_color_hex
    logger.info("string #{string_to_convert} converted to #{hexed.to_i.to_s(16)}")
    "\#" + hexed.to_i.to_s(16)
  end


end
