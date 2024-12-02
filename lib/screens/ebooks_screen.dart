import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:r_muslim/bloc/ebooks/ebooks_bloc.dart';
import 'package:r_muslim/models/ebooks_model.dart';
import 'package:r_muslim/services/ebooks_api_services.dart';
import 'package:r_muslim/style/style.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:permission_handler/permission_handler.dart';

class EbooksScreen extends StatefulWidget {
  const EbooksScreen({super.key});

  @override
  State<EbooksScreen> createState() => _EbooksScreenState();
}

class _EbooksScreenState extends State<EbooksScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EbooksBloc(EbooksApiServices())..add(FetchEbooksEvent()),
      child: Scaffold(
        backgroundColor: Colors.white,
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
                        itemCount: listEbooks.length,
                        itemBuilder: (context, index) {
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
                                    listEbooks[index].title,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: Fonts.POPPINS,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    listEbooks[index].description,
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
                                      itemCount:
                                          listEbooks[index].attachments.length,
                                      itemBuilder: (context, attachmentIndex) {
                                        final url = listEbooks[index]
                                            .attachments[attachmentIndex]
                                            .url;
                                        final extensionType = listEbooks[index]
                                            .attachments[attachmentIndex]
                                            .extensionType;

                                        return Container(
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              print('url download => $url');
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
