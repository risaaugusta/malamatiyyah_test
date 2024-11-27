import 'package:flutter/material.dart';
import 'package:r_muslim/screens/home_screen.dart';
import 'package:r_muslim/style/style.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.end,
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
                onPressed: () {},
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
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: SvgPicture.asset(
                        width: 30,
                        height: 30,
                        'images/google-icon.svg',
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
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HomeScreen()));
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
