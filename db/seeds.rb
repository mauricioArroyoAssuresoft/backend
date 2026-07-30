TeamMember.destroy_all

team_members = [
  {
    name: "Alice Johnson",
    email: "alice.johnson@example.com",
    role: :developer,
    active: true
  },
  {
    name: "Bob Smith",
    email: "bob.smith@example.com",
    role: :developer,
    active: true
  },
  {
    name: "Carol Davis",
    email: "carol.davis@example.com",
    role: :qa,
    active: true
  },
  {
    name: "David Wilson",
    email: "david.wilson@example.com",
    role: :support,
    active: true
  },
  {
    name: "Eva Brown",
    email: "eva.brown@example.com",
    role: :support,
    active: false
  }
]

TeamMember.create(team_members)
puts "Created #{TeamMember.count} team members."
