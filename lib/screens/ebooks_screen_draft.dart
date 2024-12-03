import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:r_muslim/bloc/ebooks/ebooks_bloc.dart';
import 'package:r_muslim/bloc/global/global.dart';
import 'package:r_muslim/models/ebooks_model.dart';
import 'package:r_muslim/services/ebooks_api_services.dart';
import 'package:r_muslim/style/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EbooksScreenDraft extends StatefulWidget {
  const EbooksScreenDraft({super.key});

  @override
  State<EbooksScreenDraft> createState() => _EbooksScreenState();
}

class _EbooksScreenState extends State<EbooksScreenDraft> {
  Global global = Global();
  String user = '';
   
  ValueNotifier<User?> userCredential = ValueNotifier<User?>(null);

  @override
  void initState() {
    super.initState();
    _checkIfUserIsLoggedIn();
  }

  Future<void> _checkIfUserIsLoggedIn() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? currentUser = auth.currentUser;

    if (currentUser != null) {
      setState(() {
        user = currentUser.displayName ?? 'User';
        global.email = currentUser.email ?? '';
      });

      userCredential.value = currentUser;
      final pref = await SharedPreferences.getInstance();
      pref.setString("email", global.email ?? '');
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      final pref = await SharedPreferences.getInstance();
      pref.setString("email", userCredential.user?.email ?? '');
      global.email = pref.getString("email")!;
      setState(() {
        user = userCredential.user?.displayName ?? 'User';
        global.email = global.email;
      });

      return userCredential;
    } on Exception catch (e) {
      print('Exception: $e');
      return null;
    }
  }

  Future<bool> signOutFromGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      setState(() {
        userCredential.value = null;
        user = '';
        global.email = '';
      });

      final pref = await SharedPreferences.getInstance();
      await pref.remove("email");

      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EbooksBloc(EbooksApiServices())..add(FetchEbooksEvent()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: null,
          title: const Text(
            'Malamatiyyah',
            style: TextStyle(
                color: Colors.black,
                fontFamily: Fonts.POPPINS,
                fontSize: 24,
                fontWeight: FontWeight.w900),
          ),
          backgroundColor: Colors.white,
          actions: [
            ValueListenableBuilder<User?>(
              valueListenable: userCredential,
              builder: (context, value, child) {
                return value == null
                    ? Center(
                        child: Card(
                          color: Coloring.secondary,
                          surfaceTintColor: Coloring.secondary,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            iconSize: 40,
                            icon: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 8),
                              child: SvgPicture.asset(
                                'assets/images/google-icon.svg',
                                width: 15,
                                height: 15,
                              ),
                            ),
                            onPressed: () async {
                              final UserCredential? result =
                                  await signInWithGoogle();
                              if (result != null) {
                                userCredential.value = result.user;
                                setState(() {
                                  user = userCredential.value?.displayName ?? 'User';
                                  global.email = global.email;
                                });
                              }
                            },
                          ),
                        ),
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (value?.photoURL != null)
                            Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 1.5, color: Colors.black54),
                              ),
                              child: Image.network(value!.photoURL!),
                            ),
                          const SizedBox(height: 20),
                          IconButton(
                            onPressed: () async {
                              bool result = await signOutFromGoogle();
                              if (result) {
                                userCredential.value = null;
                                setState(() {
                                  user = '';
                                  global.email = '';
                                });
                              }
                            },
                            icon: const Icon(
                              Icons.logout,
                              color: Coloring.tertiary,
                            ),
                          ),
                        ],
                      );
              },
            )
          ],
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ebooks',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: Fonts.POPPINS,
                  color: Coloring.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              global.email == ''
                  ? const Text(
                      'Silakan login untuk jelajahi lebih luas!',
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: Fonts.POPPINS,
                          color: Colors.black),
                    )
                  : RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          const TextSpan(
                            text: 'Assalamualaikum, ',
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: Fonts.POPPINS,
                                color: Colors.black),
                          ),
                          TextSpan(
                              text: '$user!',
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: Fonts.POPPINS,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
              const Divider(
                thickness: 3,
                color: Coloring.primary,
              ),
              const SizedBox(height: 10),
              BlocBuilder<EbooksBloc, EbooksState>(
                builder: (context, state) {
                  if (state is EbooksLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is EbooksError) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (state is EbooksLoaded) {
                    List<DataEbooks> listEbooks = state.listEbooks;

                    return Expanded(
                      child: ListView.builder(
                        itemCount: user == '' ? 5 : listEbooks.length,
                        itemBuilder: (context, index) {
                          final ebook = listEbooks[index];
                          return Card(
                            color: Colors.white,
                            surfaceTintColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Coloring.tertiary, width: 0.5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ebook.title,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: Fonts.POPPINS,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    ebook.description,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: Fonts.POPPINS,
                                        color: Coloring.primary,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: ebook.attachments.length,
                                      itemBuilder: (context, attachmentIndex) {
                                        final url = ebook
                                            .attachments[attachmentIndex].url;
                                        final extensionType = ebook
                                            .attachments[attachmentIndex]
                                            .extensionType;

                                        return Container(
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              if (await canLaunch(url)) {
                                                await launch(url);
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        'Could not launch the URL'),
                                                  ),
                                                );
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Coloring.primary,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 3),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Icon(
                                                  Icons.file_download,
                                                  color: Colors.white,
                                                ),
                                                const SizedBox(width: 8),
                                                Text(
                                                  'Download $extensionType',
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: Fonts.POPPINS,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(child: Text('Unknown State'));
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
