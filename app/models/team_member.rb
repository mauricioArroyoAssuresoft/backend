class TeamMember < ApplicationRecord
  enum :role, {
    developer: "developer",
    qa: "qa",
    support: "support"
  }

  validates :name, 
    presence: true
  validates :email, 
    presence: true, 
    uniqueness: true, 
    format: {
      with: URI::MailTo::EMAIL_REGEXP
    }

    validates :role, 
      presence: true

    validates :active,
      inclusion: { in: [true, false]}
end
