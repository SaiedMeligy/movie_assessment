import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_assessment/core/config/constants.dart';
import 'package:movie_assessment/features/PersonProfile/page/person_profile_screen.dart';
import 'package:movie_assessment/features/PopularPerson/manager/cubit.dart';
import 'package:movie_assessment/features/PopularPerson/manager/states.dart';

class PopularPersonPage extends StatefulWidget {
  const PopularPersonPage({super.key});

  @override
  State<PopularPersonPage> createState() => _PopularPersonPageState();
}

class _PopularPersonPageState extends State<PopularPersonPage> {
  late PopularPersonCubit popularPersonCubit;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    popularPersonCubit = PopularPersonCubit();
    popularPersonCubit.fetchPopularPerson();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 50) {
        if(!popularPersonCubit.isLoading) {
          popularPersonCubit.fetchPopularPerson(loadMore: true);
        }
      }
    });
  }

  @override
  void dispose() {
    popularPersonCubit.close();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Popular Person',
          style: Constants.theme.textTheme.titleLarge,

        ),
        centerTitle:true,
        backgroundColor: Colors.black87,


      ),
      body: Container(
        decoration: BoxDecoration(
          color: Constants.theme.primaryColor,
        ),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                BlocBuilder<PopularPersonCubit, PopularPersonStates>(
                  bloc: popularPersonCubit,
                  builder: (context, state) {
                    if (state is SuccessPopularPersonState) {
                      var popularPersons = state.results;
                      return Column(
                        children: List.generate(popularPersons.length, (index) {
                          final person = popularPersons[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return PersonProfileScreen(person: person);
                              }));
                            },
                            child: Card(
                              color: const Color(0xffFFA90A).withOpacity(0.7),
                              elevation: 6.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(7),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: Constants.mediaQuery.width * 0.25,
                                      height: Constants.mediaQuery.height * 0.2,
                                      child: CachedNetworkImage(
                                        imageUrl: "${Constants.pathImage}${person.profilePath}",
                                        imageBuilder: (context, imageProvider) => Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black54),
                                            borderRadius: BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) => const Icon(Icons.error, size: 60, color: Colors.grey),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            person.name.toString(),
                                            style: Constants.theme.textTheme.titleLarge,
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            "Popularity: ${person.popularity?.toStringAsFixed(2)}",
                                            style: Constants.theme.textTheme.bodyMedium,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      );
                    } else if (state is ErrorPopularPersonState) {
                      return Center(child: Text('An error occurred: ${state.errorMessage}'));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
