require "spec_helper"

describe GithubAuth do

  let(:omniauth_data) do
    {
      "uid"  => "123",
      "info" => {
        "nickname" => "batsman",
        "email"    => "batsman@host.com" 
      },
      "credentials" => {
        "token" => "abc"
      }
    }
  end

  subject { described_class.new(omniauth_data) }

  describe "#user_id" do
    it "returns the user id" do
      expect(subject.user_id).to eq("123")
    end
  end

  describe "#nickname" do
    it "returns the user nickname" do
      expect(subject.nickname).to eq("batsman")
    end
  end

  describe "#email" do
    it "returns the user email" do
      expect(subject.email).to eq("batsman@host.com")
    end
  end

  describe "#token" do
    it "returns the user token" do
      expect(subject.token).to eq("abc")
    end
  end
end
