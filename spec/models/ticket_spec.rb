require 'spec_helper'

describe Ticket do
  it { expect(subject).to validate_presence_of(:app) }
  it { expect(subject).to validate_presence_of(:requester) }
  it { expect(subject).to validate_presence_of(:title) }
end
