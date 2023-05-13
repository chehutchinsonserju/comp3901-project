import 'package:capstone/screens/journal.dart';
import 'package:capstone/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:capstone/style/app_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();


class LoginScreen extends StatelessWidget {
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
              Text(
                "Login",
                style: AppStyle.mainTitle,
              ),
              SizedBox(height: 20.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
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
                        MaterialStateProperty.all(Color(0xFF1D9AAD)),
                    padding: MaterialStateProperty.all(EdgeInsets.all(15.0)),
                  ),
                  onPressed: () async {
                    WidgetsFlutterBinding.ensureInitialized();
                    await Firebase.initializeApp();
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
                              builder: (context) => JournalScreen()));
                    } else {
                      print('Error Signing In');
                    }

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
