puts "Creating Organization..."
organization = Organization.create(name: "michelada.io", api_key: "SU7HSH5Yr8fXuGmfz7mD7XSHjbZ1j3gR")

puts "Creating Owner User..."
owner = User.new(
  email: "owner@checkinar.io",
  password: "12345678",
  organization_id: organization.id
)
owner.roles << :owner
owner.save

puts "email: owner@checkinar.io\npassword: 12345678\n"

puts "Seeds created!"
