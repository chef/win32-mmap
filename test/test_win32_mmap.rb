#####################################################################
# test_win32_mmap.rb
#
# Test suite for the win32-mmap package. This should be run via the
# 'rake test' task.
#####################################################################
require 'test/unit'
require 'win32/mmap'
include Win32

class TC_Win32_Mmap < Test::Unit::TestCase
   def setup
      @mmap = MMap.new(:name => 'test', :size => 100)
   end

   def test_version
      assert_equal('0.2.4', MMap::VERSION)
   end
   
   def test_dynamic_string_value
      assert_nothing_raised{ @mmap.foo = 'test' }
      assert_nothing_raised{ @mmap.bar = 'alpha123' }
      assert_equal('test', @mmap.foo)
      assert_equal('alpha123', @mmap.bar)
   end

   def test_dynamic_integer_value
      assert_nothing_raised{ @mmap.bar = 7 }
      assert_nothing_raised{ @mmap.zero = 0 }
      assert_equal(7, @mmap.bar)
      assert_equal(0, @mmap.zero)
   end

   def test_dynamic_hash_value
      assert_nothing_raised{ @mmap.ahash = {'foo' => 0} }
      assert_nothing_raised{ @mmap.bhash = {'foo' => 0, 'bar' => 'hello'} }
      assert_equal({'foo' => 0}, @mmap.ahash) 
      assert_equal({'foo' => 0, 'bar' => 'hello'}, @mmap.bhash)
   end

   def test_dynamic_array_value
      assert_nothing_raised{ @mmap.aarray = [1, 'x', 3] }
      assert_nothing_raised{ @mmap.barray = [{1 => 2}, [1,2,3], 'foo'] }
      assert_equal([1, 'x', 3], @mmap.aarray) 
      assert_equal([{1=>2}, [1,2,3], 'foo'], @mmap.barray)
   end
   
   def test_valid_options
      assert_raises(ArgumentError){ MMap.new(:foo => 1) }
   end

   def test_address
      assert_respond_to(@mmap, :address)
      assert_kind_of(Fixnum, @mmap.address)
   end
   
   def test_base_address
      assert_respond_to(@mmap, :base_address)
      assert_respond_to(@mmap, :base_address=)
      assert_kind_of(Fixnum, @mmap.base_address)
   end
   
   def test_name
      assert_respond_to(@mmap, :name)
      assert_respond_to(@mmap, :name=)
      assert_equal('test', @mmap.name)
   end
   
   def test_inherit
      assert_respond_to(@mmap, :inherit?)
      assert_respond_to(@mmap, :inherit=)
      assert_equal(false, @mmap.inherit?)
   end
   
   def test_size
      assert_respond_to(@mmap, :size)
      assert_respond_to(@mmap, :size=)
      assert_equal(100, @mmap.size)
   end
   
   def test_file
      assert_respond_to(@mmap, :file)
      assert_respond_to(@mmap, :file=)
      assert_nil(@mmap.file)
   end
   
   def test_access
      assert_respond_to(@mmap, :access)
      assert_respond_to(@mmap, :access=)
   end
   
   def test_autolock
      assert_respond_to(@mmap, :autolock?)
      assert_respond_to(@mmap, :autolock=)
      assert_equal(true, @mmap.autolock?)
   end
   
   def test_protection
      assert_respond_to(@mmap, :protection)
      assert_respond_to(@mmap, :protection=)
      assert_equal(4, @mmap.protection)
   end
   
   def teardown
      @mmap.close
   end
end
