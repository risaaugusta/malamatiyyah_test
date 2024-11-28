import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:r_muslim/models/list_surah_model.dart';
import 'package:r_muslim/services/surah_api_services.dart';
import 'package:r_muslim/bloc/surah/surah_bloc.dart';
import 'package:r_muslim/style/style.dart';

class SurahScreen extends StatelessWidget {
  const SurahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SurahBloc(SurahApiServices())..add(FetchSurahEvent()), // Menambahkan event FetchSurahEvent
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
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
                    color: Coloring.primary,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Surah',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: Fonts.POPPINS,
                  color: Coloring.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              BlocBuilder<SurahBloc, SurahState>(
                builder: (context, state) {
                  if (state is SurahLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SurahError) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (state is SurahLoaded) {
                    List<DataListSurah> listSurat = state.listSurah;
                    return Expanded(
                      child: ListView.builder(
                        itemCount: listSurat.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.star),
                                title: Text(listSurat[index].nama),
                                subtitle: Text(listSurat[index].tempatTurun),
                              ),
                              if (index < listSurat.length - 1)
                                const Divider(),
                            ],
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(child: Text('Unknown State'));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
