import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskfive/data/auth_service.dart';
import 'package:taskfive/data/dummy_user.dart';
import 'package:taskfive/models/user.dart';

/// Provides the current authenticated user (or null when not logged in).
final authProvider = AsyncNotifierProvider<AuthNotifier, User?>(
  AuthNotifier.new,
);

class AuthNotifier extends AsyncNotifier<User?> {
  @override
  Future<User?> build() async {
    // If developer mode enabled, return dummy user immediately
    if (useDummyAuth) {
      return Future.value(User.fromMap(dummyUser));
    }

    // Try to restore session from saved token
    final token = await AuthService.getToken();
    if (token == null) return null;
    final map = await AuthService.fetchUserData(token);
    return User.fromMap(map);
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    final res = await AuthService.login(email: email, password: password);
    final token = res['token'] as String?;
    if (token == null) {
      state = AsyncValue.error(Exception('Login failed'), StackTrace.current);
      return;
    }

    final map = await AuthService.fetchUserData(token);
    state = AsyncValue.data(User.fromMap(map));
  }

  Future<void> logout() async {
    await AuthService.logout();
    state = const AsyncValue.data(null);
  }
}
