import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:r_muslim/models/doa_model.dart';
import 'package:r_muslim/services/doa_api_services.dart';
import 'package:r_muslim/bloc/doa/doa_bloc.dart';
import 'package:r_muslim/style/style.dart';

class DoaScreen extends StatelessWidget {
  const DoaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoaBloc(DoaApiServices())..add(const FetchDoaEvent()),
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
                  'Doa',
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
                'Doa',
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
              BlocBuilder<DoaBloc, DoaState>(
                builder: (context, state) {
                  if (state is DoaLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is DoaError) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (state is DoaLoaded) {
                    List<DoaModel> listDoa = state.listDoa;
                    return Expanded(
                      child: ListView.builder(
                        itemCount: listDoa.length,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                // leading: Container(
                                //   padding: const EdgeInsets.symmetric(
                                //       horizontal: 12, vertical: 8),
                                //   decoration: BoxDecoration(
                                //     color: Colors.white,
                                //     borderRadius: BorderRadius.circular(100),
                                //     border: Border.all(
                                //       color: Coloring.primary,
                                //       width: 2,
                                //     ),
                                //   ),
                                //   child: Text('${index + 1}'),
                                // ),
                                title: Text(
                                  listDoa[index].nama, 
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: Fonts.POPPINS,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                ),
                                // subtitle: Container(
                                //   padding:const EdgeInsets.symmetric(horizontal: 8),
                                //   width: MediaQuery.of(context).size.width/6,
                                //   height: 20,
                                //   decoration: BoxDecoration(
                                //     color: Coloring.secondary,
                                //     borderRadius: BorderRadius.circular(20),
                                //   ),
                                //   child: Text(
                                //     listDoa[index].tag,
                                //     style: const TextStyle(
                                //       fontSize: 12,
                                //       fontFamily: Fonts.POPPINS,
                                //       color: Coloring.primary,
                                //     ),
                                //   ),
                                // ),
                              ),
                              Text(
                                listDoa[index].ar,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontFamily: Fonts.POPPINS,
                                    color: Coloring.primary,
                                ),
                              ),
                              Text(
                                listDoa[index].tr,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: Fonts.POPPINS,
                                    color: Colors.black),
                              ),
                              Text(
                                'Arti: "${listDoa[index].idn}"',
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: Fonts.POPPINS,
                                    color: Coloring.tertiary),
                              ),
                              listDoa[index].tag != ''
                                  ? Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 3),
                                      width: MediaQuery.of(context).size.width,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: Coloring.secondary,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        listDoa[index].tag,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontFamily: Fonts.POPPINS,
                                          color: Coloring.primary,
                                        ),
                                      ),
                                    )
                                  : Container(),
                              if (index < listDoa.length - 1) const Divider(),
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
