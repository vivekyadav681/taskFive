class ResumeExperience {
  ResumeExperience({
    required this.company,
    required this.role,
    this.from,
    this.to,
    this.description,
  });
  final String company;
  final String role;
  final String? from;
  final String? to;
  final String? description;

  factory ResumeExperience.fromMap(Map m) => ResumeExperience(
    company: (m['company'] ?? '').toString(),
    role: (m['role'] ?? '').toString(),
    from: m['from']?.toString(),
    to: m['to']?.toString(),
    description: m['description']?.toString(),
  );

  Map<String, dynamic> toMap() => {
    'company': company,
    'role': role,
    'from': from,
    'to': to,
    'description': description,
  };
}

class Resume {
  Resume({this.summary, this.education = const [], this.experience = const []});
  final String? summary;
  final List<Map<String, dynamic>> education;
  final List<ResumeExperience> experience;

  factory Resume.fromMap(Map m) => Resume(
    summary: m['summary']?.toString(),
    education: (m['education'] is List)
        ? List<Map<String, dynamic>>.from(m['education'])
        : [],
    experience: (m['experience'] is List)
        ? (m['experience'] as List)
              .map(
                (e) => ResumeExperience.fromMap(Map<String, dynamic>.from(e)),
              )
              .toList()
        : [],
  );

  Map<String, dynamic> toMap() => {
    'summary': summary,
    'education': education,
    'experience': experience.map((e) => e.toMap()).toList(),
  };
}

class User {
  User({
    required this.id,
    required this.fullname,
    required this.email,
    this.role,
    this.profilePicture,
    this.location,
    this.createdAt,
    this.resume,
    this.token,
  });

  final String id;
  final String fullname;
  final String email;
  final String? role;
  final String? profilePicture;
  final String? location;
  final DateTime? createdAt;
  final Resume? resume;
  final String? token;

  factory User.fromMap(Map<String, dynamic> m) {
    final userMap = m['user'] is Map ? Map<String, dynamic>.from(m['user']) : m;
    return User(
      id: (userMap['id'] ?? userMap['uid'] ?? '').toString(),
      fullname: (userMap['fullname'] ?? userMap['name'] ?? '').toString(),
      email: (userMap['email'] ?? '').toString(),
      role: userMap['role']?.toString(),
      profilePicture: userMap['profilePicture']?.toString(),
      location: userMap['location']?.toString(),
      createdAt: userMap['createdAt'] != null
          ? DateTime.tryParse(userMap['createdAt'].toString())
          : null,
      resume: userMap['resume'] is Map
          ? Resume.fromMap(Map<String, dynamic>.from(userMap['resume']))
          : null,
      token: m['token']?.toString(),
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'fullname': fullname,
    'email': email,
    'role': role,
    'profilePicture': profilePicture,
    'location': location,
    'createdAt': createdAt?.toIso8601String(),
    'resume': resume?.toMap(),
    'token': token,
  };
}
