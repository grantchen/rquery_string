require 'cgi'

module RqueryString
  class Generator
    def self.build_query_string(hash_para)
      query_string = ""
      hash_para.each do |key, value|
        begin
          query_string << (send "build_#{value.class.to_s.downcase}_type".to_sym, CGI::escape(key.to_s), value) << "&"
        rescue NoMethodError => e
          query_string << "#{key}=#{value}&"
        end
      end
      return query_string[0..query_string.length - 2]
    end

    private

    def self.build_hash_type(hash_key, hash_value)
      query_string = ""
      hash_value.each do |key, value|
        query_string << (send "build_#{value.class.to_s.downcase}_type".to_sym,
                         "#{hash_key}[#{key}]", value) << "&"
      end
      return query_string[0..query_string.length - 2]
    end

    def self.build_string_type(key, value)
      str_value = "'" + value + "'"
      "#{key}=#{CGI::escape(str_value)}"
    end

    def self.build_array_type(key, value)
      query_string = ""
      value.each_index do |index|
        query_string << (send "build_#{value[index].class.to_s.downcase}_type".to_sym,
                         "#{key}[#{index}]", value[index]) << "&"
      end
      return query_string[0..query_string.length - 2]
    end

  end
end
