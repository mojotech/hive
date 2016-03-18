require 'spec_helper'

describe Epic do
  it { expect(subject).to validate_presence_of(:app) }
end
