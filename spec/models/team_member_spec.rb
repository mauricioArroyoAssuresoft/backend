require "rails_helper"

RSpec.describe TeamMember, type: :model do
  subject(:team_member) do
    described_class.new(
      name: "Mauricio Arroyo",
      email: "mauricio@example.com",
      role: :developer,
      active: true
    )
  end

  describe "validations" do
    it "is valid with valid attributes" do
      expect(team_member).to be_valid
    end

    it "is invalid without a name" do
      team_member.name = nil

      expect(team_member).not_to be_valid
      expect(team_member.errors[:name]).to include("can't be blank")
    end

    it "is invalid without an email" do
      team_member.email = nil

      expect(team_member).not_to be_valid
      expect(team_member.errors[:email]).to include("can't be blank")
    end

    it "is invalid with an invalid email format" do
      team_member.email = "invalid-email"

      expect(team_member).not_to be_valid
      expect(team_member.errors[:email]).to include("is invalid")
    end

    it "is invalid without a role" do
      team_member.role = nil

      expect(team_member).not_to be_valid
      expect(team_member.errors[:role]).to include("can't be blank")
    end

    it "is invalid without an active value" do
      team_member.active = nil

      expect(team_member).not_to be_valid
      expect(team_member.errors[:active]).to include("is not included in the list")
    end

    it "requires a unique email" do
      described_class.create!(
        name: "John Doe",
        email: "mauricio@example.com",
        role: :developer,
        active: true
      )

      duplicate = described_class.new(
        name: "Jane Doe",
        email: "mauricio@example.com",
        role: :qa,
        active: true
      )

      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:email]).to include("has already been taken")
    end
  end

  describe "enums" do
    it "defines the expected roles" do
      expect(described_class.roles.keys).to contain_exactly(
        "developer",
        "qa",
        "support"
      )
    end
  end
end
