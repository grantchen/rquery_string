require 'cgi'

module RqueryString
  class Generator
    def self.build_query_string(hash_para)
      query_string = ""
      hash_para.each do |key, value|
        begin
          query_string << (send "build_#{value.class.to_s.downcase}_type".to_sym, escape_key(key), value) << "&"
        rescue NoMethodError => e
          query_string << "#{escape_key(key)}=#{value}&"
        end
      end
      return query_string[0..query_string.length - 2]
    end

    private

    def self.build_hash_type(hash_key, hash_value)
      query_string = ""
      hash_value.each do |key, value|
        new_key = "#{hash_key}[#{escape_key(key)}]"
        begin
          query_string << (send "build_#{value.class.to_s.downcase}_type".to_sym,
                         "#{new_key}", value) << "&"
        rescue NoMethodError => e
          query_string << "#{new_key}=#{value}&"
        end
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
        begin
          query_string << (send "build_#{value[index].class.to_s.downcase}_type".to_sym,
                         "#{key}[]", value[index]) << "&"
        rescue NoMethodError => e
          query_string << "#{key}[]=#{value[index]}&"
        end
      end
      return query_string[0..query_string.length - 2]
    end

    def self.escape_key(key)
      if key.is_a? String
        key = "'" + key + "'"
      end
      CGI::escape(key.to_s)
    end

  end
end
