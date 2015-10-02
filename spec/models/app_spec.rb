require 'spec_helper'

describe App do
  it 'has a valid factory' do
    expect(build :app).to be_valid
  end
end
