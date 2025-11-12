import 'package:flutter/material.dart';
import 'package:taskfive/data/auth_service.dart';
import 'package:taskfive/screens/login/login_screen.dart';

/// Screen displayed after a successful password-reset OTP verification.
///
/// The user enters a new password and confirms it. On successful update,
/// we navigate back to the login screen.
class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen(this.email, {super.key});

  /// The email for which the password is being reset.
  final String email;

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateNewPassword(String? value) {
    if (value == null || value.trim().isEmpty) return 'Enter new password';
    if (value.trim().length < 6)
      return 'Password must be at least 6 characters';
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.trim().isEmpty) return 'Confirm your password';
    if (value.trim() != _newPasswordController.text.trim())
      return 'Passwords do not match';
    return null;
  }

  Future<void> _showMessage(String title, String message) async {
    if (!mounted) return;
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    final newPassword = _newPasswordController.text.trim();
    final confirm = _confirmPasswordController.text.trim();

    try {
      // The backend expects: email, oldpassword, newpassword (some servers use
      // a dedicated reset endpoint). Here updatePassword is reused; ensure the
      // server accepts the payload we send.
      await AuthService.updatePassword(
        email: widget.email,
        newPassword: newPassword,
        confirmPassword: confirm,
      );

      await _showMessage(
        'Password updated',
        'Your password has been updated. Please login with your new password.',
      );

      if (!mounted) return;
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
    } catch (e) {
      await _showMessage('Error', 'Failed to update password: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Mask email for privacy: show only first and domain
    final displayedEmail = _maskEmail(widget.email);

    return Scaffold(
      appBar: AppBar(title: const Text('Set New Password')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Resetting password for $displayedEmail'),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _newPasswordController,
                  decoration: const InputDecoration(
                    label: Text('New password'),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: _validateNewPassword,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                    label: Text('Confirm password'),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: _validateConfirmPassword,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _submit,
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Update Password'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _maskEmail(String email) {
    try {
      final parts = email.split('@');
      if (parts.length != 2) return email;
      final name = parts[0];
      final domain = parts[1];
      final shown = name.length <= 2 ? name : '${name.substring(0, 2)}...';
      return '$shown@$domain';
    } catch (_) {
      return email;
    }
  }
}
