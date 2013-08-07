$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/rquery_string"
require 'generator'

module RqueryString
  extend self

  def build(para_hash)
    Generator.build_query_string(para_hash)
  end

end
