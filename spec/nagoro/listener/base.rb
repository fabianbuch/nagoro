require 'lib/nagoro'
require 'spec'

describe 'Nagoro::Listener::Base' do
  def base(string)
    nagoro = Nagoro::Template[:Base]
    nagoro.pipeline(string)
  end

  it 'should not stumble over HTML entities' do
    %w[gt lt quot amp nbsp uuml].each do |entity|
      str = "&#{entity};" 
      base(str).should == str
    end
  end
end
