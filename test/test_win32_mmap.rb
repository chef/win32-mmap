#####################################################################
# test_win32_mmap.rb
#
# Test suite for the win32-mmap package. This should be run via the
# 'rake test' task.
#####################################################################
require 'test-unit'
require 'win32/mmap'
include Win32

class TC_Win32_Mmap < Test::Unit::TestCase
  def setup
    @mmap = MMap.new(:name => 'test', :size => 100)
  end

  test "version is set to expected value" do
    assert_equal('0.3.2', MMap::VERSION)
  end

  test "dynamic variable names and string values work as expected" do
    assert_nothing_raised{ @mmap.foo = 'test' }
    assert_nothing_raised{ @mmap.bar = 'alpha123' }
    assert_equal('test', @mmap.foo)
    assert_equal('alpha123', @mmap.bar)
  end

  test "dynamic variable names and integer values work as expected" do
    assert_nothing_raised{ @mmap.bar = 7 }
    assert_nothing_raised{ @mmap.zero = 0 }
    assert_equal(7, @mmap.bar)
    assert_equal(0, @mmap.zero)
  end

  test "dynamic variable names and hash values work as expected" do
    assert_nothing_raised{ @mmap.ahash = {'foo' => 0} }
    assert_nothing_raised{ @mmap.bhash = {'foo' => 0, 'bar' => 'hello'} }
    assert_equal({'foo' => 0}, @mmap.ahash)
    assert_equal({'foo' => 0, 'bar' => 'hello'}, @mmap.bhash)
  end

  test "dynamic variable names and array values work as expected" do
    assert_nothing_raised{ @mmap.aarray = [1, 'x', 3] }
    assert_nothing_raised{ @mmap.barray = [{1 => 2}, [1,2,3], 'foo'] }
    assert_equal([1, 'x', 3], @mmap.aarray)
    assert_equal([{1=>2}, [1,2,3], 'foo'], @mmap.barray)
  end

  test "passing an invalid option raises an argument error" do
    assert_raises(ArgumentError){ MMap.new(:foo => 1) }
  end

  test "address method basic functionality" do
    assert_respond_to(@mmap, :address)
    assert_kind_of(Fixnum, @mmap.address)
  end

  test "base_address method basic functionality" do
    assert_respond_to(@mmap, :base_address)
    assert_respond_to(@mmap, :base_address=)
    assert_kind_of(Fixnum, @mmap.base_address)
  end

  test "name accessor basic functionality" do
    assert_respond_to(@mmap, :name)
    assert_respond_to(@mmap, :name=)
    assert_equal('test', @mmap.name)
  end

  test "inherit accessor basic functionality" do
    assert_respond_to(@mmap, :inherit?)
    assert_respond_to(@mmap, :inherit=)
    assert_equal(false, @mmap.inherit?)
  end

  test "size accessor basic functionality" do
    assert_respond_to(@mmap, :size)
    assert_respond_to(@mmap, :size=)
    assert_equal(100, @mmap.size)
  end

  test "file accessor basic functionality" do
    assert_respond_to(@mmap, :file)
    assert_respond_to(@mmap, :file=)
    assert_nil(@mmap.file)
  end

  test "access accessor basic functionality" do
    assert_respond_to(@mmap, :access)
    assert_respond_to(@mmap, :access=)
  end

  test "autolock accessor basic functionality" do
    assert_respond_to(@mmap, :autolock?)
    assert_respond_to(@mmap, :autolock=)
    assert_equal(true, @mmap.autolock?)
  end

  test "protection accessor basic functionality" do
    assert_respond_to(@mmap, :protection)
    assert_respond_to(@mmap, :protection=)
    assert_equal(4, @mmap.protection)
  end

  def teardown
    @mmap.close
  end
end
