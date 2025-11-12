class User {
  User({
    required this.id,
    required this.fullname,
    required this.email,
    this.role,
    this.profilePicture,
    this.location,
    this.createdAt,
  });

  final String id;
  final String fullname;
  final String email;
  final String? role;
  final String? profilePicture;
  final String? location;
  final DateTime? createdAt;
}
