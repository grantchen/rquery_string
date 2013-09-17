require 'cgi'

module RqueryString
  class Parser

    def self.parse(query_string)
      hash_pair_array = query_string.split("&")
      result_hash = Hash.new
      hash_pair_array.each do |hash_value|
        key, value = hash_value.split("=")
        if is_array(key)
          parse_array(key, value, result_hash)
        elsif is_string(value)
          result_hash[key] = parse_string(value)
        else
          result_hash[key] = eval(value)
        end
      end
      return result_hash
    end

    private

    def self.is_array(key)
      key.end_with?("]") && ((key.rindex("[")+ 3) ==  key.length)
    end

    def self.is_string(value)
      value.start_with?("%27") && value.end_with?("%27")
    end

    def self.parse_array(key, value, result_hash)
      array_key = key[0..key.index("[") - 1]
      result_hash[array_key] = [] if result_hash[array_key].nil?
      result_hash[array_key] << value
    end

    def self.parse_string(value)
      value[3..value.rindex("%27")-1]
    end
  end
end
