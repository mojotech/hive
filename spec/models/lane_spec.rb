require 'spec_helper'

describe Lane do
  it { expect(subject).to validate_presence_of(:app) }
  it { expect(subject).to validate_presence_of(:title) }
end
