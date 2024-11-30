import 'package:flutter/material.dart';
import 'package:r_muslim/models/detail_surah_model.dart';
import 'package:r_muslim/screens/home_screen.dart';
import 'package:r_muslim/services/surah_api_services.dart';
import 'package:r_muslim/style/style.dart';

class DetailSurahScreen extends StatefulWidget {
  final int surahId;
  final String namaSurah;

  const DetailSurahScreen(
      {super.key, required this.surahId, required this.namaSurah});

  @override
  _DetailSurahScreenState createState() => _DetailSurahScreenState();
}

class _DetailSurahScreenState extends State<DetailSurahScreen> {
  late Future<Data> _detailSurahFuture;
  bool _isLoading = true;
  String _errorMessage = '';
  late SurahApiServices _surahApiServices;

  @override
  void initState() {
    super.initState();
    _detailSurahFuture = _fetchDetailSurah(widget.surahId);
  }

  Future<Data> _fetchDetailSurah(int id) async {
    try {
      final data = await SurahApiServices().fetchDetailSurah(id);
      setState(() {
        _isLoading = false;
      });
      return data;
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Terjadi kesalahan: $e';
      });
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          },
        ),
        title: Text(
          widget.namaSurah,
          style: const TextStyle(
              color: Colors.black,
              fontFamily: Fonts.POPPINS,
              fontSize: 16,
              fontWeight: FontWeight.w900),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<Data>(
        future: _detailSurahFuture,
        builder: (context, snapshot) {
          if (_isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(_errorMessage));
          }

          if (snapshot.hasData) {
            final data = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Text(
                    data.nama,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontFamily: Fonts.POPPINS,
                      color: Coloring.primary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    data.namaLatin,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontFamily: Fonts.POPPINS,
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(data.arti,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        fontFamily: Fonts.POPPINS,
                        color: Coloring.tertiary,
                      )),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data.tempatTurun,
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: Fonts.POPPINS,
                            color: Coloring.tertiary,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text('•',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: Fonts.POPPINS,
                              color: Coloring.tertiary,
                            )),
                        const SizedBox(width: 10),
                        Text('${data.jumlahAyat} ayat',
                            style: const TextStyle(
                              fontSize: 12,
                              fontFamily: Fonts.POPPINS,
                              color: Coloring.tertiary,
                            )),
                      ]),
                  const SizedBox(height: 16.0),
                  if (data.audioFull.isNotEmpty) ...[
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.resolveWith<Color>(
                          (Set<WidgetState> states) {
                            return Coloring.secondary;
                          },
                        ),
                        elevation: WidgetStateProperty.all(0),
                        minimumSize: WidgetStateProperty.all(
                            const Size(double.infinity, 40)),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Audio Surah'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: data.audioFull.entries
                                    .map((entry) => ListTile(
                                          title: Text(entry.key),
                                          subtitle: Text(entry.value),
                                        ))
                                    .toList(),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Tutup'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text('Lihat Audio',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: Fonts.POPPINS,
                              color: Coloring.primary,
                              fontWeight: FontWeight.w900)),
                    ),
                    const SizedBox(height: 16.0),
                  ],
                  ...data.ayat.map((ayat) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                        color: Coloring.primary,
                                        width: 1,
                                      ),
                                    ),
                                    child: Text('${ayat.nomorAyat}',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontFamily: Fonts.POPPINS,
                                            color: Coloring.primary,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  Expanded(
                                    child: Text(
                                      ayat.teksArab,
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontFamily: Fonts.POPPINS,
                                          color: Coloring.primary,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ]),
                            const SizedBox(height: 4.0),
                            Text(
                              ayat.teksLatin,
                            ),
                            const SizedBox(height: 4.0),
                            Text(ayat.teksIndonesia,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: Fonts.POPPINS,
                                    color: Coloring.tertiary)),
                          ],
                        ),
                      ),
                    );
                  })
                ],
              ),
            );
          }

          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
