// Temporary dummy user to bypass login during development.
// This map mimics a realistic backend response for a logged-in user.
// Set `useDummyAuth` to true to have the app treat this user as authenticated.

const bool useDummyAuth = true;

final Map<String, dynamic> dummyUser = {
  // top-level token if your backend returns a token alongside user data
  'token': 'dummy-token-xxxxxxxxxxxx',

  // user payload
  'user': {
    'id': 'user_0001',
    'fullname': 'Jane Developer',
    'email': 'jane.developer@example.com',
    'role': 'job_seeker',
    'profilePicture': null,
    'location': 'Remote',
    'createdAt': DateTime.utc(2024, 1, 1).toIso8601String(),
    'resume': {
      'summary': 'Experienced Flutter developer with a focus on mobile UX.',
      'education': [
        {
          'school': 'State University',
          'degree': 'BSc Computer Science',
          'year': 2020,
        },
      ],
      'experience': [
        {
          'company': 'Example Co',
          'role': 'Flutter Developer',
          'from': '2021-01-01',
          'to': '2023-06-30',
          'description':
              'Built and maintained cross-platform mobile apps using Flutter.',
        },
      ],
    },
    // companies the user follows (minimal representation)
    'following': [
      {'id': 'comp_01', 'title': 'Example Co', 'location': 'Anywhere'},
    ],
  },
};
