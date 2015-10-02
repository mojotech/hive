require 'spec_helper'

describe Ticket do
  it { expect(subject).to validate_presence_of(:app) }
end
