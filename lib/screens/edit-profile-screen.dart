import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'change-password-screen.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;
  const EditProfileScreen({required this.user});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  bool _isEmailTaken = false;

  @override
  void initState() {
    _nameController =
        TextEditingController(text: widget.user.displayName ?? '');
    _emailController = TextEditingController(text: widget.user.email ?? '');
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<bool> _isEmailInUse(String email) async {
    try {
      final methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      return methods.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<void> _updateProfile() async {
    final newName = _nameController.text.trim();
    final newEmail = _emailController.text.trim();

    if (newName.isNotEmpty) {
      await widget.user.updateDisplayName(newName);
    }
    if (newEmail.isNotEmpty && widget.user.email != newEmail) {
      final isEmailTaken = await _isEmailInUse(newEmail);
      if (isEmailTaken) {
        setState(() {
          _isEmailTaken = true;
        });
        return;
      }
      await widget.user.updateEmail(newEmail);
    }

    final User? updatedUser = await FirebaseAuth.instance.currentUser;
    Navigator.pop(context, updatedUser);
  }

  void _goToChangePasswordScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChangePasswordScreen(user: widget.user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Display Name',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                errorText:
                    _isEmailTaken ? 'This email is already taken.' : null,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _updateProfile,
              child: Text('Save'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _goToChangePasswordScreen,
              child: Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }
}
