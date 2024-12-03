import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInScreen extends StatefulWidget {
  const GoogleSignInScreen({super.key});

  @override
  State<GoogleSignInScreen> createState() => _GoogleSignInScreenState();
}

class _GoogleSignInScreenState extends State<GoogleSignInScreen> {
  ValueNotifier<UserCredential?> userCredential = ValueNotifier<UserCredential?>(null);

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
      appBar:  AppBar(title: Text('Google SignIn Screen')),
      body: ValueListenableBuilder<UserCredential?>(
        valueListenable: userCredential,
        builder: (context, value, child) {
          return value == null
              ? Center(
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      iconSize: 40,
                      icon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                        child: SvgPicture.asset(
                          'assets/images/google-icon.svg',
                          width: 15,
                          height: 15,
                        ),
                      ),
                      onPressed: () async {
                        final UserCredential? result = await signInWithGoogle();
                        if (result != null) {
                          userCredential.value = result;
                        }
                      },
                    ),
                  ),
                )
              : Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (value.user?.photoURL != null)
                        Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 1.5, color: Colors.black54),
                          ),
                          child: Image.network(value.user!.photoURL!),
                        ),
                      const SizedBox(height: 20),
                      Text(value.user?.displayName ?? 'No Name'),
                      const SizedBox(height: 20),
                      Text(value.user?.email ?? 'No Email'),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () async {
                          bool result = await signOutFromGoogle();
                          if (result) {
                            userCredential.value = null; 
                          }
                        },
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
