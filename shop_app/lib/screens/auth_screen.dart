import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/http_exception.dart';
import 'package:shop_app/screens/product_overview_screen.dart';

import 'dart:math';
import '../providers/auth.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Auth'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                    Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0, 1]),
            ),
          ),
          Container(
            width: deviceSize.width,
            height: deviceSize.height,
            child: Column(
              children: [
                Flexible(
                  child: Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.symmetric(horizontal: 94, vertical: 8),
                    transform: Matrix4.rotationZ(-8 * pi / 180)
                      ..translate(-10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepOrange.shade900,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, 2),
                          )
                        ]),
                    child: Text(
                      'MyShop',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color,
                        fontSize: 50,
                        fontFamily: 'Anton',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: deviceSize.width > 600 ? 2 : 1,
                  child: AuthCard(),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -0.25),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    ));
    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.ease,
    ));
    // _slideAnimation.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred'),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'))
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    try {
      if (_authMode == AuthMode.Login) {
        // Login
        await Provider.of<Auth>(context, listen: false)
            .login(_authData['email']!, _authData['password']!);
      } else {
        // Signup
        await Provider.of<Auth>(context, listen: false)
            .signUp(_authData['email']!, _authData['password']!);
      }
      Navigator.of(context)
          .pushReplacementNamed(ProductOverviewScreen.routeName);
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS'))
        errorMessage = 'The email address is already in use.';
      else if (error.toString().contains('INVALID EMAIL'))
        errorMessage = 'This is not invalid email address.';
      else if (error.toString().contains('EMAIL_EXISTS'))
        errorMessage = 'The email address is already in use.';
      else if (error.toString().contains('WEAK_PASSWORD'))
        errorMessage = 'This password is too weak.';
      else if (error.toString().contains('EMAIL_NOT_FOUND'))
        errorMessage = 'Could not find a user with that email.';
      else if (error.toString().contains('INVALID_PASSWORD'))
        errorMessage = 'Invalid password.';
      _showErrorDialog(errorMessage);
    } catch (error) {
      print('Loi day' + error.toString());
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _animationController.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 8,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.Login ? 260 : 320),
        width: deviceSize.width * 0.75,
        height: _authMode == AuthMode.Login ? 260 : 320,
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                  },
                  onSaved: (value) {
                    _authData['email'] = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Password is too short';
                    }
                  },
                  onSaved: (value) {
                    _authData['password'] = value!;
                  },
                ),
                if (_authMode == AuthMode.Signup)
                  AnimatedContainer(
                    constraints: BoxConstraints(
                      minHeight: _authMode == AuthMode.Login ? 0 : 60,
                      maxHeight: _authMode == AuthMode.Login ? 0 : 120,
                    ),
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                    child: FadeTransition(
                      opacity: _opacityAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: TextFormField(
                          enabled: _authMode == AuthMode.Signup,
                          decoration:
                              InputDecoration(labelText: 'Confirm Password'),
                          obscureText: true,
                          validator: _authMode == AuthMode.Signup
                              ? (value) {
                                  if (value != _passwordController.text) {
                                    return 'Password is too short';
                                  }
                                }
                              : null,
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 20),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: _submit,
                    child:
                        Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGNUP'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      textStyle: TextStyle(
                          color:
                              Theme.of(context).primaryTextTheme.button!.color),
                      primary: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                TextButton(
                  onPressed: _switchAuthMode,
                  child: _authMode == AuthMode.Login
                      ? Text('SIGNUP INSTEAD')
                      : Text('LOGIN INSTEAD'),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 4),
                    textStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
