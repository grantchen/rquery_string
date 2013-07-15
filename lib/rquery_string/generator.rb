module RqueryString
  class Generator
    def self.build_query_string(hash_para)
      query_string = ""
      hash_para.each do |key, value|
        query_string << (send "build_#{value.class.to_s.downcase}_type".to_sym, key, value) << "&"
      end
      return query_string[0..query_string.length - 2]
    end

    private

    def self.build_hash_type(hash_key, hash_value)
      query_string = ""
      hash_value.each do |key, value|
        query_string << (send "build_#{value.class.to_s.downcase}_type".to_sym, "#{hash_key}[#{key}]", value) << "&"
      end
      return query_string[0..query_string.length - 2]
    end

    def self.build_string_type(key, value)
      "#{key}=#{value}"
    end
  end
end
