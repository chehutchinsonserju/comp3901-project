import 'package:capstone/screens/signup.dart';
import 'package:capstone/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:capstone/style/app_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:capstone/components/auth_service.dart';

final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();

}
class _LoginScreenState extends State<LoginScreen> {

  void handleLogin() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    GoogleSignIn googleSignIn = GoogleSignIn();
    googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final UserCredential userCredential =
    await FirebaseAuth.instance.signInWithCredential(credential);
    final User? user = userCredential.user;
    if(user!= null){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen()));
    } else {
      print('Error Signing In');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', height: 100),
              SizedBox(height: 20.0),
              Text(
                "Login",
                style: AppStyle.mainTitle,
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.grey[800]),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[800]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[800]!),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.grey[800]),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[800]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[800]!),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(Color(0x407CFC00)),
                    padding: MaterialStateProperty.all(EdgeInsets.all(15.0)),
                  ),
                  onPressed: () async {
                    WidgetsFlutterBinding.ensureInitialized();
                    await Firebase.initializeApp();
                    final AuthService _authService = AuthService();
                    User? user = await _authService.loginUsingEmailPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );

                    if(user!= null){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    } else {
                      print('Error Signing In');
                    }

                  },
                  child: Text(
                    "Sign in",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                "or",
                style: AppStyle.mainTitle,
              ),
              SizedBox(height: 10.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFF1D9AAD)),
                    padding: MaterialStateProperty.all(EdgeInsets.all(15.0)),
                  ),
                  onPressed: () async {
                    handleLogin();

                  },
                  child: Text(
                    "Sign in with Google",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don’t have an account? ",
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 10.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        color: Color(0xFF1D9AAD),
                        fontSize: 10.0,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Text(
                    " or ",
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 10.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Use PIN",
                      style: TextStyle(
                        color: Color(0xFF1D9AAD),
                        fontSize: 10.0,
                        fontWeight: FontWeight.normal,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
