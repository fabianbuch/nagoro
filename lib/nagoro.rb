class Hash
  def to_tag_params
    inject('') do |s,v|
      s << %{ #{v[0]}="#{v[1]}"}
    end
  end
end

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.uniq!

require 'nagoro/version'
require 'nagoro/error'
require 'nagoro/element'
require 'nagoro/template'
require 'nagoro/pipe/base'
require 'nagoro/pipe/element'
require 'nagoro/pipe/morph'
require 'nagoro/pipe/instruction'
require 'nagoro/pipe/include'

module Nagoro
  class << self
    def load_libxml
      require "nagoro/wrap/libxml_reader"
      :libxml
    end

    def load_rexml
      # puts "Please install libxml-ruby for better performance, using REXML now."
      require 'nagoro/wrap/rexml'
      :rexml
    end
  end
end

engine = ENV['NAGORO_ENGINE'] || 'rexml'
engine = engine.downcase

engine =
  begin
    Nagoro.send("load_#{engine}")
  rescue LoadError => ex
    puts ex
    Nagoro::load_rexml
  end

Nagoro::ENGINE = engine
