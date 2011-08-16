# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
@user = User.find_or_create_by_email("llh@llh.com") do |u|
  u.password = u.password_confirmation = "123456"
  u.gender = "male"
  u.superadmin = true
  u.role = "admin"
end

Profile.create(:user => @user, :name => "llh")

# HEAD
@user = User.find_or_create_by_email("lx@lx.com") do |u|
  u.password = u.password_confirmation = "123456"
  u.gender = "male"
  u.role = "admin"
end

Profile.create(:user => @user, :name => "lx")


