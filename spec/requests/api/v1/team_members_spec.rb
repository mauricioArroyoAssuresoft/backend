require "rails_helper"

RSpec.describe "Api::V1::TeamMembers", type: :request do
  describe "GET /api/v1/team_members" do
    before do
      TeamMember.create!(
        name: "John Doe",
        email: "john@example.com",
        role: :developer,
        active: true
      )

      TeamMember.create!(
        name: "Jane Smith",
        email: "jane@example.com",
        role: :qa,
        active: false
      )
    end

    it "returns all team members" do
      get "/api/v1/team_members"

      expect(response).to have_http_status(:ok)

      body = JSON.parse(response.body)

      expect(body.size).to eq(2)
      expect(body.first["name"]).to eq("John Doe")
      expect(body.second["name"]).to eq("Jane Smith")
    end
  end

  describe "POST /api/v1/team_members" do
    let(:valid_params) do
      {
        team_member: {
          name: "Mauricio Arroyo",
          email: "mauricio@example.com",
          role: "developer",
          active: true
        }
      }
    end

    let(:invalid_params) do
      {
        team_member: {
          name: "",
          email: "invalid-email",
          role: "",
          active: nil
        }
      }
    end

    it "creates a team member" do
      expect do
        post "/api/v1/team_members", params: valid_params
      end.to change(TeamMember, :count).by(1)

      expect(response).to have_http_status(:created)

      body = JSON.parse(response.body)

      expect(body["name"]).to eq("Mauricio Arroyo")
      expect(body["email"]).to eq("mauricio@example.com")
    end

    it "returns validation errors" do
      post "/api/v1/team_members", params: invalid_params

      expect(response).to have_http_status(:unprocessable_entity)

      body = JSON.parse(response.body)

      expect(body["error"]).to eq("Validation failed")
      expect(body["details"]).not_to be_empty
    end
  end

  describe "PATCH /api/v1/team_members/:id" do
    let!(:team_member) do
      TeamMember.create!(
        name: "John Doe",
        email: "john@example.com",
        role: :developer,
        active: true
      )
    end

    it "updates a team member" do
      patch "/api/v1/team_members/#{team_member.id}",
            params: {
              team_member: {
                name: "John Updated",
                active: false
              }
            }

      expect(response).to have_http_status(:ok)

      team_member.reload

      expect(team_member.name).to eq("John Updated")
      expect(team_member.active).to be(false)
    end

    it "returns not found for an invalid id" do
      patch "/api/v1/team_members/999999",
            params: {
              team_member: {
                name: "Nobody"
              }
            }

      expect(response).to have_http_status(:not_found)

      body = JSON.parse(response.body)

      expect(body["error"]).to eq("Team member not found")
    end
  end
end
