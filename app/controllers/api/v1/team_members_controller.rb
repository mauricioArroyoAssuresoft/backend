module Api
  module V1
    class TeamMembersController < ApplicationController
      def index
        team_members = TeamMember.all

        render json: team_members, status: :ok
      end

      def create
        team_member = TeamMember.new(team_member_params)

        if team_member.save
          render json: team_member, status: :created
        else
          render json: {
            error: "Validation failed",
            details: team_member.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      def update
        team_member = TeamMember.find(params[:id])

        if team_member.update(team_member_params)
          render json: team_member, status: :ok
        else
          render json: {
            error: "Validation failed",
            details: team_member.errors.full_messages
          }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Team member not found" }, status: :not_found
      end

      private

      def team_member_params
        params.require(:team_member).permit(
          :name,
          :email,
          :role,
          :active
        )
      end
    end
  end
end
