// login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:r_muslim/screens/home_screen.dart';
import 'package:r_muslim/style/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ValueNotifier<UserCredential?> userCredential =
      ValueNotifier<UserCredential?>(null);

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      print('Exception: $e');
      return null;
    }
  }

  Future<bool> signOutFromGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Malamatiyyah',
              style: TextStyle(
                  fontFamily: Fonts.POPPINS,
                  fontSize: 24,
                  fontWeight: FontWeight.w800),
            ),
            const Text(
              'Islamic app for your daily faith booster',
              style: TextStyle(fontFamily: Fonts.POPPINS, fontSize: 12),
            ),
            const SizedBox(height: 20),
            SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                child: Image.asset('assets/images/splash.png')),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: ElevatedButton(
                onPressed: () async {
                  final UserCredential? result = await signInWithGoogle();
                  if (result != null) {
                    userCredential.value = result;
                  }
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) {
                      return Coloring.secondary;
                    },
                  ),
                  elevation: WidgetStateProperty.all(0),
                  minimumSize:
                      WidgetStateProperty.all(const Size(double.infinity, 40)),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 8),
                      child: SvgPicture.asset(
                        width: 15,
                        height: 15,
                        'assets/images/google-icon.svg',
                      ),
                    ),
                    const Text(
                      "Login with Google",
                      style: TextStyle(
                        fontFamily: Fonts.POPPINS,
                        color: Coloring.primary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) {
                      return Coloring.secondary;
                    },
                  ),
                  elevation: WidgetStateProperty.all(0),
                  minimumSize:
                      WidgetStateProperty.all(const Size(double.infinity, 40)),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                child: const Text(
                  "Login as guest",
                  style: TextStyle(
                    fontFamily: Fonts.POPPINS,
                    color: Coloring.primary,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
