import 'package:flutter/material.dart';
import 'package:qr_employee/screens/qr_screen.dart';
import 'package:qr_employee/services/authentication_service.dart';
import 'package:qr_employee/widgets/popup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/custom_colors.dart';
import '../../widgets/custom_elevated_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final String _uid = "uid";

  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }

  void _checkCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString(_uid);

    if (userId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QRScreen(uid: userId),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    String logoImage = "assets/mekatroniklogo.png";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.appBarColor,
        title: const Text('Giriş Yap'),
      ),
      backgroundColor: CustomColors.textButtonColor,
      body: Padding(
        padding: const EdgeInsets.all(36),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              imageContainer(logoImage, height),
              const SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Kullanıcı Adı'),
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Şifre'),
                obscureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomElevatedButton(
                onPressed: _login,
                buttonText: 'Giriş Yap',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    String uid = await AuthenticationService().signIn(
      "${_usernameController.text}@mail.com",
      _passwordController.text,
    );
    if (uid == "null") {
      popUp(context, "Hatalı Giriş", "Kullanıcı adı veya Şifreniz Hatalı");
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(_uid, uid);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QRScreen(uid: uid),
        ),
      );
    }
  }

  Container imageContainer(String logoImage, double height) {
    return Container(
      height: height * .13,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(logoImage),
        ),
      ),
    );
  }
}
