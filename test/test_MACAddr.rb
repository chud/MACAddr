# unit test for MACAddr
require 'lib/MACAddr'
require 'test/unit'

#
# MACAddr is a class for the manipulation of Media Access Control addresses
# it is patterned after the IPAddr class found in the std ruby libraries
#
class TestMACAddr < Test::Unit::TestCase
  def test_to_i
    assert_equal(0, MACAddr.new("00:00:00:00:00:00").to_i)
    assert_equal(0x0000000f0f0f, MACAddr.new("00:00:00:0F:0F:0F").to_i)
    assert_equal((2**48)-1, MACAddr.new("ff:ff:ff:ff:ff:ff").to_i)
  end

  def test_to_s
    assert_equal("00:00:00:00:00:00", MACAddr.new("00:00:00:00:00:00").to_s)
    assert_equal("ff:ff:ff:ff:ff:ff", MACAddr.new("ff:ff:ff:ff:ff:ff").to_s)
  end

  # test missing initalizer, goofy init strings and valid strings
  def test_init
    assert_raise(ArgumentError) { MACAddr.new()}
    assert_raise(ArgumentError) { MACAddr.new("00k00k00.00.00.00")}
    assert_raise(ArgumentError) { MACAddr.new("0g:00:00:00:00:00")}
    assert_raise(ArgumentError) { MACAddr.new(":00:00:00:00:00")}
    assert_raise(ArgumentError) { MACAddr.new("00:00:00:00:00")}
    assert_raise(ArgumentError) { MACAddr.new("00:00::00:00:00")}
    assert_nothing_raised(ArgumentError) { MACAddr.new("00:00:00:00:00:00")}
    assert_nothing_raised(ArgumentError) { MACAddr.new("0:00:00:00:00:00")}

  end

  def test_equality
    assert_equal(MACAddr.new("00:00:00:00:00:00"), MACAddr.new("00:00:00:00:00:00"))
    assert_equal(MACAddr.new("a0:b0:c0:d0:e0:f0"), MACAddr.new("a0:b0:c0:d0:e0:f0"))
#    assert_not_equal(MACAddr.new("00:b0:c0:d0:e0:f0"), MACAddr.new("a0:b0:c0:d0:e0:f0"))
  end

  def test_vendor_membership
    assert_equal("CISCO SYSTEMS, INC.", MACAddr.new("00:00:0C:03:05:06").vendor_name)
    assert_not_equal("CISCO SYSTEMS, INC.", MACAddr.new("00:00:0d:03:05:06").vendor_name)
    assert_equal("CISCO SYSTEMS, INC.", MACAddr.new("00:00:0c:00:00:00").vendor_name)
    assert_equal("00:00:0c:00:00:00", MACAddr.new("00:00:0c:03:05:06").vendor_oid)
  end
end
