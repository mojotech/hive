require 'spec_helper'

describe User do
  it 'has a valid factory' do
    expect(build :user).to be_valid
  end

  it { expect(subject).to validate_presence_of(:github_user_id) }
  it { expect(subject).to validate_presence_of(:nickname) }
  it { expect(subject).to validate_presence_of(:email) }
  it { expect(subject).to validate_presence_of(:auth_token) }
end
