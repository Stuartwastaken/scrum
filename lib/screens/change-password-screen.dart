import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
<<<<<<< HEAD

class ChangePasswordScreen extends StatefulWidget {
  final User user;

  const ChangePasswordScreen({Key? key, required this.user}) : super(key: key);
=======
import 'edit-profile-screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);
>>>>>>> 1716638 (Added screen to change password)

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  late User _currentUser;
<<<<<<< HEAD
=======
  late String _newPassword;
>>>>>>> 1716638 (Added screen to change password)

  @override
  void initState() {
    _currentUser = FirebaseAuth.instance.currentUser!;
    super.initState();
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _changePassword() async {
    final form = _formKey.currentState;
    if (form!.validate()) {
      final oldPassword = _oldPasswordController.text;
      final newPassword = _newPasswordController.text;
      final confirmPassword = _confirmPasswordController.text;
      if (newPassword != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
<<<<<<< HEAD
          const SnackBar(
=======
          SnackBar(
>>>>>>> 1716638 (Added screen to change password)
            content: Text('New password and confirm password do not match'),
          ),
        );
        return;
      }
<<<<<<< HEAD

=======
>>>>>>> 1716638 (Added screen to change password)
      try {
        final credential = EmailAuthProvider.credential(
            email: _currentUser.email!, password: oldPassword);
        await _currentUser.reauthenticateWithCredential(credential);
        await _currentUser.updatePassword(newPassword);
<<<<<<< HEAD
        await _currentUser.reload();
        final User? updatedUser = FirebaseAuth.instance.currentUser;
        Navigator.pop(context, updatedUser);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
=======
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
>>>>>>> 1716638 (Added screen to change password)
            content: Text('Password changed successfully'),
          ),
        );
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message!),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
<<<<<<< HEAD
          const SnackBar(
=======
          SnackBar(
>>>>>>> 1716638 (Added screen to change password)
            content: Text('An error occurred. Please try again.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        title: const Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _oldPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Current Password',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your current password';
                  } else if (value.length < 6) {
                    return 'Your password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'New Password',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a new password';
                  } else if (value.length < 6) {
                    return 'Your password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm New Password',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please confirm your new password';
                  } else if (value != _newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _changePassword,
                child: const Text('Change Password'),
              ),
            ],
          ),
=======
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Current Password',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your current password';
                } else if (value.length < 6) {
                  return 'Your password must be at least 6 characters long';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'New Password',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a new password';
                } else if (value.length < 6) {
                  return 'Your password must be at least 6 characters long';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please confirm your new password';
                } else if (value != _newPasswordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _changePassword,
              child: Text('Change Password'),
            ),
          ],
>>>>>>> 1716638 (Added screen to change password)
        ),
      ),
    );
  }
}
