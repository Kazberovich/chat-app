import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_firestore_app/widgets/pickers/avatar_picker.dart';

class AuthForm extends StatefulWidget {
  final bool isLoading;

  final void Function(
    String email,
    String password,
    String username,
    File image,
    bool isLogin,
    BuildContext ctx,
  ) submitFunction;

  AuthForm(this.submitFunction, this.isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  File _userImageFile;

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    //Focus.of(context).unfocus();

    widget.submitFunction(
      _userEmail.trim(),
      _userPassword.trim(),
      _userName.trim(),
      _userImageFile,
      _isLogin,
      context,
    );

    if (_userImageFile == null && !_isLogin) {
      Scaffold.of(context)
          .showBottomSheet((context) => Text("No image uploaded"));
      return;
    }

    if (isValid) {
      _formKey.currentState.save();

      // Use those values to send our auth request...
    }
  }

  void _pickedImageFn(File pickedImageFile) {
    _userImageFile = pickedImageFile;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Form(
                key: _formKey,
                child: Column(
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!_isLogin) AvatarPicker(_pickedImageFn),
                    TextFormField(
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      enableSuggestions: false,
                      key: ValueKey('email'),
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email address';
                        } else
                          return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                      ),
                      onSaved: (value) {
                        _userEmail = value;
                      },
                    ),
                    if (!_isLogin)
                      TextFormField(
                        autocorrect: true,
                        textCapitalization: TextCapitalization.words,
                        enableSuggestions: false,
                        key: ValueKey('Username'),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Username',
                        ),
                        validator: (value) {
                          if (value.isEmpty || value.length < 4) {
                            return 'Username must be at least 4 characters long';
                          } else
                            return null;
                        },
                        onSaved: (value) {
                          _userName = value;
                        },
                      ),
                    TextFormField(
                      key: ValueKey('Password'),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if (value.isEmpty || value.length < 7) {
                          return 'Password must be at least 7 characters long';
                        } else
                          return null;
                      },
                      onSaved: (value) {
                        _userPassword = value;
                      },
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    if (widget.isLoading) CircularProgressIndicator(),
                    if (!widget.isLoading)
                      ElevatedButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          _trySubmit();
                        },
                        child: Text(_isLogin ? 'Login' : 'Signup'),
                      ),
                    if (!widget.isLoading)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(_isLogin
                            ? 'Creat new account'
                            : 'I already have an account'),
                      ),
                    OutlinedButton(
                      onPressed: () {},
                      child: Text('Not actual. Creat new account'),
                    ),
                  ],
                )),
          ),
        ),
        margin: EdgeInsets.all(20),
      ),
    );
  }
}
