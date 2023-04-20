include ApplicationHelper
pass1 = ApplicationHelper.generate_password
admin1 = User.create(name: 'admin1', email: 'admin1@blockbuster.com', password: pass1)
p "Admin1 credentials #{admin1.email} - #{pass1}"
pass2 = ApplicationHelper.generate_password
admin2 = User.create(name: 'admin2', email: 'admin2@blockbuster.com', password: pass2)
p "Admin2 credentials #{admin2.email} - #{pass2}"
