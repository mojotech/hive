require 'spec_helper'

describe Ticket do
  it 'has a valid factory' do
    expect(build :ticket).to be_valid
  end

  it { expect(subject).to validate_presence_of(:app) }
  it { expect(subject).to validate_presence_of(:requester) }
  it { expect(subject).to validate_presence_of(:title) }

  describe 'branch_name' do
    let(:ticket) { create :ticket }

    it 'includes the title' do
      expect(ticket.branch_name).to include ticket.title.parameterize
    end

    it 'includes the id' do
      expect(ticket.branch_name).to match(%r{.*/#{ticket.id}/.*})
    end

    context 'ticket has an owner' do
      let(:owner) { create :user }
      let(:ticket) { create :ticket, owner: owner }

      it 'includes the owner nickname' do
        expect(ticket.branch_name).to match(/#{owner.nickname}\/.*/)
      end
    end
  end
end
