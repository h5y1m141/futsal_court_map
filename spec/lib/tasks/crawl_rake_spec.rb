require 'spec_helper'

describe 'crawl:run' do
  include_context 'rake'
  before do
    @crawl = Crawl.new
  end
  it 'should be valid' do
    
    expect(@crawl.respond_to?(:run)).to be true
  end
end
