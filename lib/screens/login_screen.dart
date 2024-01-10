import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_employee/screens/qr_screen.dart';
import 'package:qr_employee/services/auth_service.dart';
import 'package:qr_employee/services/shared_pref.dart';
import '../../utils/constants.dart';
import '../../utils/custom_colors.dart';
import '../../widgets/custom_elevated_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoggingIn = false;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }

  Future<void> _checkCurrentUser() async {
    if (await SharedPref.allExist(
        [Constants.uidKey, Constants.userName, Constants.userPassword])) {
      _navigateToQRScreen(await SharedPref.getString(Constants.uidKey)!);
    }
  }

  void _navigateToQRScreen(String uid) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => QRScreen(uid: uid),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.textButtonColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                Constants.logo,
                fit: BoxFit.fitWidth,
                height: 150.0,
              ),
              const SizedBox(height: 80.0),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Kullanıcı Adı',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Şifre',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20.0),
              CustomElevatedButton(
                onPressed: _isLoggingIn ? null : () => _login(),
                buttonText: 'Giriş Yap',
                child: _isLoggingIn ? const CircularProgressIndicator() : null,
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    setState(() => _isLoggingIn = true);

    UserCredential? credential = await AuthService.signInWithEmailAndPassword(
      "${_usernameController.text}@mail.com",
      _passwordController.text,
    );

    setState(() => _isLoggingIn = false);

    if (credential == null) {
      _showSnackBar('Giriş Yapılamadı');
      return;
    }

    SharedPref.setString(Constants.uidKey, credential.user!.uid);
    SharedPref.setString(Constants.userName, _usernameController.text);
    SharedPref.setString(Constants.userPassword, _passwordController.text);
    _navigateToQRScreen(credential.user!.uid);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
