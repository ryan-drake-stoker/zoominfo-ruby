module ZoomInfo
module UpperCaseCamelize
   def capatilizeHashKeys(hash)
      out_hsh = {}
      hash.each do |key, value|
        if value.is_a? Hash
          value = capatilizeHashKeys value
        elsif value.is_a? Array
          value = handle_array value
        end
        new_key = key.dup
        new_key[0] = new_key[0].capitalize
        out_hsh[new_key] = value
      end
     out_hsh
   end

  def handle_array(array)
    array.map do |elem|
       if elem.is_a? Hash
         capatilizeHashKeys elem
       elsif elem.is_a? Array
         handle_array elem
       else
         elem
       end
    end
  end
end
end

