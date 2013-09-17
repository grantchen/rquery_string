$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/rquery_string"
require 'generator'
require 'parser'

module RqueryString
  extend self

  def build(para_hash)
    Generator.build_query_string(para_hash)
  end

  def parse(query_string)
    Parser.parse(query_string)
  end

end