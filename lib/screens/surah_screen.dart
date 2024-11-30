import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:r_muslim/models/list_surah_model.dart';
import 'package:r_muslim/screens/detail_surah_screen.dart';
import 'package:r_muslim/services/surah_api_services.dart';
import 'package:r_muslim/bloc/surah/surah_bloc.dart';
import 'package:r_muslim/style/style.dart';

class SurahScreen extends StatelessWidget {
  const SurahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SurahBloc(SurahApiServices())..add(FetchSurahEvent()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 16,
                height: MediaQuery.of(context).size.height / 6,
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/banner-quran.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: const Text(
                  'Qur\'an',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: Fonts.POPPINS,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
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
              const Divider(
                thickness: 3,
                color: Coloring.primary,
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
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => DetailSurahScreen(surahId: index+1, namaSurah: listSurat[index].namaLatin),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          ListTile(
                                              leading: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 8),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  border: Border.all(
                                                    color: Coloring.primary,
                                                    width: 2,
                                                  ),
                                                ),
                                                child: Text('${index + 1}'),
                                              ),
                                              title: Text(
                                                listSurat[index].namaLatin,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: Fonts.POPPINS,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              subtitle: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      listSurat[index]
                                                          .tempatTurun,
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontFamily:
                                                            Fonts.POPPINS,
                                                        color:
                                                            Coloring.tertiary,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    const Text('•',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontFamily:
                                                              Fonts.POPPINS,
                                                          color:
                                                              Coloring.tertiary,
                                                        )),
                                                    const SizedBox(width: 10),
                                                    Text(
                                                        '${listSurat[index].jumlahAyat} ayat',
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          fontFamily:
                                                              Fonts.POPPINS,
                                                          color:
                                                              Coloring.tertiary,
                                                        )),
                                                  ])),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        listSurat[index].nama,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontFamily: Fonts.POPPINS,
                                            color: Coloring.primary,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (index < listSurat.length - 1) const Divider(),
                            ],
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
