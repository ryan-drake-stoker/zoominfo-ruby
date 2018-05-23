require File.expand_path(File.dirname(__FILE__) + '/spec_helper')



describe 'UpperCase the keys in the hash' do

  it 'when a simple hash is provided' do
    upper = CapitalizeHash.new
    res = upper.capatilizeHashKeys({'ab' => 'cdef'})
    res['Ab'].should  == 'cdef'
  end

  it 'when a longer hash is provided' do
    upper = CapitalizeHash.new
    res = upper.capatilizeHashKeys({'abCD' => 'cdef', 'ab' => '1234'})
    res['AbCD'].should  == 'cdef'
  end

  it 'when a hash is within a hash' do
    upper = CapitalizeHash.new
    res = upper.capatilizeHashKeys({'abCD' => {'ab' => 'cdef'}})
    res['AbCD']['Ab'].should  == 'cdef'
  end

  it 'when a hash is within an array' do
    upper = CapitalizeHash.new
    res = upper.capatilizeHashKeys({'abCD' => [{'ab' => 'cdef'}]})
    res['AbCD'].first['Ab'].should  == 'cdef'
  end

end