enum Role { job_giver, job_seeker }

class User {
  User({required this.name, required this.email, required this.role});
  String name;
  String email;
  Role role;
}

User? user;