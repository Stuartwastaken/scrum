import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfilePopup extends StatefulWidget {
  final User user;
  const EditProfilePopup({required this.user});

  @override
  _EditProfilePopupState createState() => _EditProfilePopupState();
}

class _EditProfilePopupState extends State<EditProfilePopup> {
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
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Successfully edited profile'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Profile'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "New Username",
              ),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "New Email",
                errorText:
                    _isEmailTaken ? 'This email is already taken.' : null,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text("Cancel"),
          onPressed: () {
            final User? updatedUser = FirebaseAuth.instance.currentUser;
            Navigator.pop(context, updatedUser);
          },
        ),
        TextButton(
          onPressed: _updateProfile,
          child: Text("Save"),
        ),
      ],
    );
  }
}
