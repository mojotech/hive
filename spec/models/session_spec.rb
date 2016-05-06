require 'spec_helper'

describe Session do
  let(:auth)    { double('GithubAuth') }
  let(:session) { double('ActionDispatch::Request::Session') }

  let(:request) do
    double(
      'ActionDispatch::Request',
      session: session,
      env:     {}
    )
  end

  subject { described_class.new(request) }

  before do
    allow(GithubAuth).to receive(:new) { auth }
  end

  describe '#create' do
    context 'for an exisiting user' do
      let(:user) { FactoryGirl.create(:user) }

      before do
        allow(auth).to receive(:user_id) { user.github_user_id }
      end

      it 'sets the user session' do
        expect(session).to receive(:[]=).with(:user_id, user.id)

        subject.create
      end
    end

    context 'for a new user' do
      before do
        {
          user_id:  '1batsman',
          nickname: 'batsman',
          email:    'batsman@host.com',
          token:    'abc'
        }.each do |attr, val|
          allow(auth).to receive(attr) { val }
        end
      end

      it 'creates a new user to the session' do
        expect(session).to receive(:[]=)

        expect { subject.create }.to change { User.count }.by(1)
      end
    end
  end

  describe '#destroy' do
    it 'clears the user session' do
      expect(session).to receive(:[]=).with(:user_id, nil)

      subject.destroy
    end
  end
end
