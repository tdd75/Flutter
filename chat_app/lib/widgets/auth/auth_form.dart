import 'package:flutter/material.dart';
import 'dart:io';

import '../pickers/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final Function(String userEmail, String userPassword, String? username,
      File? userImage, bool isLogin, BuildContext ctx) submitFn;
  final bool _isLoading;

  const AuthForm(this.submitFn, this._isLoading, {Key? key}) : super(key: key);
  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  bool _isLogin = true;
  late String _userEmail;
  late String _userPassword;
  String? _userName;
  File? _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    final _isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_userImageFile == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please pick an image.'),
      ));
      return;
    }
    if (_isValid) {
      _formKey.currentState!.save();
      widget.submitFn(_userEmail.trim(), _userPassword.trim(), _userName,
          _userImageFile, _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!_isLogin) UserImagePicker(_pickedImage),
                TextFormField(
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  enableSuggestions: false,
                  key: const ValueKey('email'),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email Address'),
                  onSaved: (value) {
                    _userEmail = value!;
                  },
                ),
                if (!_isLogin)
                  TextFormField(
                    autocorrect: false,
                    textCapitalization: TextCapitalization.words,
                    enableSuggestions: false,
                    key: const ValueKey('username'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 4) {
                        return 'Please enter at least 4 characters long.';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: 'Username'),
                    onSaved: (value) {
                      _userName = value!;
                    },
                  ),
                TextFormField(
                  key: const ValueKey('password'),
                  validator: (value) {
                    if (value!.isEmpty || value.length < 7) {
                      return 'Password must be at least 7 characters long.';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  onSaved: (value) {
                    _userPassword = value!;
                  },
                ),
                const SizedBox(height: 12),
                if (widget._isLoading)
                  const Center(child: CircularProgressIndicator()),
                if (!widget._isLoading)
                  ElevatedButton(
                    child: Text(_isLogin ? 'Login' : 'Signup'),
                    onPressed: _trySubmit,
                  ),
                TextButton(
                  child: Text(_isLogin
                      ? 'Create new account'
                      : 'I already have an account'),
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
