# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
User.create!(identification:  "admin-tulua",
			 name:  "Admin",
             last_name: "admin",
             activated: true,
             permission_level: 3,
             email: "campusvirtualtulua@correounivalle.edu.co",
             password:              "campusvirtualtulua",
             password_confirmation: "campusvirtualtulua")
