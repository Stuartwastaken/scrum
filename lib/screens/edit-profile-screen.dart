import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
<<<<<<< HEAD
import 'change-password-screen.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;
=======

class EditProfileScreen extends StatefulWidget {
  final User user;

>>>>>>> b50c583 (Added edit-profile-screen)
  const EditProfileScreen({required this.user});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
<<<<<<< HEAD
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
=======
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String? _username;
  String? _email;

  @override
  void initState() {
    super.initState();
    _usernameController.text = widget.user.displayName ?? '';
    _emailController.text = widget.user.email ?? '';
  }

  void _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _username = _usernameController.text.trim();
        _email = _emailController.text.trim();
      });

      try {
        await widget.user.updateDisplayName(_username!);
        await widget.user.updateEmail(_email!);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Profile updated successfully.'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating profile.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
>>>>>>> b50c583 (Added edit-profile-screen)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
<<<<<<< HEAD
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
=======
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an email';
                  } else if (!value.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveChanges,
                child: Text('Save Changes'),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('View Profile'),
              ),
            ],
          ),
>>>>>>> b50c583 (Added edit-profile-screen)
        ),
      ),
    );
  }
}
