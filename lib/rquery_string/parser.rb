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
        elsif is_hash(key)
          parse_hash(key, value, result_hash)
        elsif is_string(value)
          result_hash[parse_key(key)] = parse_string(value)
        else
          result_hash[parse_key(key)] = eval(value)
        end
      end
      return result_hash
    end

    private

    def self.is_array(key)
      key.end_with?("]") && ((key.index("[")+ 2) ==  key.length)
    end

    def self.is_hash(key)
      key.end_with?("]") && ((key.index("[")+ 1) < key.rindex("]"))
    end

    def self.is_string(value)
      value.start_with?("%27") && value.end_with?("%27")
    end

    def self.parse_array(key, value, result_hash)
      array_key = parse_key(key[0..key.index("[") - 1])
      result_hash[array_key] = [] if result_hash[array_key].nil?
      result_hash[array_key] << parse_value(value)
    end

    def self.parse_hash(key, value, result_hash)
      hash_key = parse_key(key[0..key.index("[") - 1])
      keys = key[key.index("[")..-1].split("]").reverse
      sub_result_object = nil
      keys.each_index do |index|
        sub_key = parse_key(keys[index][1..-1])
        sub_hash_value = sub_result_object
        if sub_key == :""
          sub_result_object = Array.new
          if sub_hash_value
            sub_result_object << sub_hash_value
          else
            sub_result_object << parse_value(value)
          end
        else
          sub_result_object = Hash.new
          if index == 0
            sub_result_object[sub_key] = parse_value(value)
          else
            sub_result_object[sub_key] = sub_hash_value
          end
        end
      end
      if result_hash[hash_key].nil?
        result_hash[hash_key] = sub_result_object
      else
        if sub_result_object.instance_of?(Array) && sub_result_object.instance_of?(Array)
          result_hash[hash_key].concat sub_result_object
        else
          merge_array_value(result_hash[hash_key], sub_result_object)
          result_hash[hash_key].merge! sub_result_object
        end
      end
    end

    def self.parse_string(value)
      CGI::unescape(value[3..value.rindex("%27")-1])
    end

    def self.parse_value(value)
      if is_string(value)
        parse_string(value)
      else
        eval(value)
      end
    end

    def self.parse_key(key)
      if is_string(key)
        return parse_string(key)
      else
        return key.to_sym
      end
    end

    def self.merge_array_value(old_hash_value, new_hash_value)
       old_hash_value.each do |key, value|
          if value.instance_of?(Array) && new_hash_value[key].instance_of?(Array)
              new_hash_value[key] = value.concat new_hash_value[key]
          else
            if value.instance_of?(Hash) && new_hash_value[key].instance_of?(Hash)
              merge_array_value(old_hash_value[key], new_hash_value[key])
            end
          end
       end
    end
  end
end
