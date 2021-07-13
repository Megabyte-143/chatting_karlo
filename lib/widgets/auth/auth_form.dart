import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  //const AuthForm({Key? key}) : super(key: key);

  AuthForm(
    this.submitFn,
    this.isLoading,
  );

  final void Function(
    String userEmail,
    String userName,
    String userPassword,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;
  final bool isLoading;
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  var _isLogin = true;

  void _trySubmit(BuildContext context) {
    final _isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (_isValid) {
      _formKey.currentState!.save();
      // print(_userEmail);
      // print(_userName);
      // print(_userPassword);
      widget.submitFn(
        _userEmail.trim(),
        _userName.trim(),
        _userPassword.trim(),
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Card(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      key: ValueKey('Email'),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains("@")) {
                          return "Please Enter A valid Email";
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (value) {
                        _userEmail = value.toString();
                      },
                    ),
                    if (!_isLogin)
                      TextFormField(
                        key: ValueKey('Username'),
                        validator: (value) {
                          if (value!.isEmpty || value.length < 4) {
                            return "Please Enter A username of more than 4 characters";
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'Username'),
                        onSaved: (value) {
                          _userName = value.toString();
                        },
                      ),
                    TextFormField(
                      key: ValueKey('Password'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 7) {
                          return "Please Enter Password of more than 7 characters";
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      onSaved: (value) {
                        _userPassword = value.toString();
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (widget.isLoading) CircularProgressIndicator(),
                    if (!widget.isLoading)
                      ElevatedButton(
                        onPressed: () {
                          _trySubmit(context);
                        },
                        child: Text(
                          _isLogin ? "Login" : "SignUp",
                        ),
                      ),
                    if (!widget.isLoading)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(
                          !_isLogin
                              ? "I already have an account"
                              : "Create Another account",
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
