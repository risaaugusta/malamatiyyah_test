// home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:r_muslim/screens/doa_screen.dart';
import 'package:r_muslim/screens/ebooks_screen.dart';
import 'package:r_muslim/screens/surah_screen.dart';
import 'package:r_muslim/style/style.dart';
import 'package:r_muslim/bloc/surah/surah_bloc.dart'; // Pastikan import Bloc
import 'package:r_muslim/services/surah_api_services.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Pastikan api service sudah ada

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<String> _titles = ['Qur\'an', 'Doa', 'Ebooks', 'Video'];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.amber,
      appBar: AppBar(
        leading: null,
        title: const Text(
          // _titles[_selectedIndex],
          'Malamatiyyah',
          style: const TextStyle(
              color: Colors.black,
              fontFamily: Fonts.POPPINS,
              fontSize: 24,
              fontWeight: FontWeight.w900),
        ),
        backgroundColor: Colors.white,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Coloring.secondary,
              borderRadius: BorderRadius.circular(50),
            ),
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/images/google-icon.svg',
                height: 20.0,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: _selectedIndex == 0 
          ? const SurahScreen()
          : _selectedIndex == 1
          ? const DoaScreen()
          : _selectedIndex == 2
          ? const EbooksScreen()
          : Center(
              child: Text(
                'Content for ${_titles[_selectedIndex]}',
                style: TextStyle(fontSize: 24),
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        useLegacyColorScheme: false,
        backgroundColor: Colors.white,
        elevation: 5,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Coloring.primary,
        unselectedItemColor: Coloring.tertiary,
        unselectedLabelStyle: const TextStyle(
            color: Coloring.tertiary, fontFamily: Fonts.POPPINS),
        selectedLabelStyle:
            const TextStyle(color: Coloring.primary, fontFamily: Fonts.POPPINS),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Qur\'an',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Doa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Ebooks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_collection),
            label: 'Video',
          ),
        ],
      ),
    );
  }
}
