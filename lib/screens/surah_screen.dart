import 'package:flutter/material.dart';
import 'package:r_muslim/style/style.dart';

class SurahScreen extends StatefulWidget {
  const SurahScreen({super.key});

  @override
  State<SurahScreen> createState() => _SurahScreenState();
}

class _SurahScreenState extends State<SurahScreen> {
  List<String> items = List.generate(20, (index) => 'Item ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView( 
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.blue[100],
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  'Surah',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: Fonts.POPPINS,
                      color: Coloring.primary),
                ),
              ),
              const SizedBox(
                  height: 20), // Spacer between container and ListView
              const Text(
                'Surah',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: Fonts.POPPINS,
                    color: Coloring.primary,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                // This container holds the dynamic ListView
                height: 300, // Fixed height for the ListView container
                child: ListView.builder(
                  shrinkWrap: true, // ListView takes as much space as it needs
                  physics:
                      const NeverScrollableScrollPhysics(), // Disable internal scrolling
                  itemCount: items.length, // Total number of items in the list
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.star),
                          title: Text(items[index]),
                        ),
                        // Divider between each list item
                        if (index <
                            items.length -
                                1) // Avoid adding a divider after the last item
                          const Divider(),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
