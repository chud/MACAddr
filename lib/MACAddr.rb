#
# MACAddr.rb - A class for manipulation of 
# network media access control addresses
#
# it is patterned after the IPAddr class 
# found in the std ruby libraries
#  
# Contact:
#  - Raymond P Chudzinski <ray@chudzinski.net> (current maintainer)
#
#  TODO:
#   - vendor lookup from OID
#
class MACAddr


  private
  def initialize(mac_addr)
    @mac_addr = mac_addr
    re_parse = /^([[:xdigit:]]{1,2}):([[:xdigit:]]{1,2}):([[:xdigit:]]{1,2}):([[:xdigit:]]{1,2}):([[:xdigit:]]{1,2}):([[:xdigit:]]{1,2})?$/
    if @words = re_parse.match(@mac_addr)
    else
      raise ArgumentError, "Invalid format - usage XX:XX:XX:XX:XX:XX"
    end #end else
  end

  public
  def ==(other)
      return self.to_i == other.to_i
  end

  def addr
      return self.words if defined? self.words and self.words
  end

  def to_s
    @words[0]
  end

  def to_i
    theInt = "0x" << "#{@words[1]}" << "#{@words[2]}" << "#{@words[3]}" \
      << "#{@words[4]}" << "#{@words[5]}" <<"#{@words[6]}"
    theInt.hex
  end

  def vendor_name
    "Cisco Systems"
  end

  def vendor_oid
    "00:00:0c:00:00:00"
  end
  
  #
  #
  # data structure containing the IEEE oui list of registered addresses
  # this list is updated periodically and released as a minor gem version
  #
  # Date Created: July, 10th 2010 - gem version 0.5.0
  #

end
