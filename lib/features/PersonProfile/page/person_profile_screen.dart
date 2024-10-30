import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_assessment/core/config/constants.dart';
import 'package:movie_assessment/features/PersonProfile/manager/cubit.dart';
import 'package:movie_assessment/features/PersonProfile/manager/states.dart';
import '../../../domain/models/PopularPersonModel.dart';
import 'full_screen_image.dart';

class PersonProfileScreen extends StatefulWidget {
  final Results person;
  const PersonProfileScreen({super.key, required this.person});

  @override
  State<PersonProfileScreen> createState() => _PersonProfileScreenState();
}

class _PersonProfileScreenState extends State<PersonProfileScreen> {
  late PersonProfileCubit personProfileCubit;

  @override
  void initState() {
    super.initState();
    personProfileCubit = PersonProfileCubit();
    personProfileCubit.fetchPersonProfile(widget.person.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.person.name.toString()),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Constants.theme.primaryColor
        ),
        child: SingleChildScrollView(
          child: BlocBuilder<PersonProfileCubit, PersonProfileStates>(
            bloc: personProfileCubit,
            builder: (context, state) {
              if (state is SuccessPersonProfileStates) {
                var profileList = state.profile;
                var knownList = widget.person.knownFor;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 100,
                          backgroundImage: CachedNetworkImageProvider(
                            "${Constants.pathImage}${widget.person.profilePath}",
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Text(
                          widget.person.name.toString(),
                          style: Constants.theme.textTheme.titleLarge,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: Text(
                          "Popularity: ${widget.person.popularity?.toStringAsFixed(2)}",
                          style: Constants.theme.textTheme.bodyMedium,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Profiles:",
                        style: Constants.theme.textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          itemCount: profileList.length,
                          itemBuilder: (context, index) {
                            final profile = profileList[index];
                            final aspectRatio = profile.aspectRatio;

                            return AspectRatio(
                              aspectRatio: aspectRatio!,
                              child: SizedBox(
                                height: profile.height?.toDouble(),
                                width: profile.width?.toDouble(),
                                child: InkWell(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FullImageScreen(
                                          imageUrl:
                                          "https://image.tmdb.org/t/p/original/${profile.filePath}",
                                        ),
                                      ),
                                    );
                                  },
                                  child: CachedNetworkImage(
                                    imageUrl:
                                    "https://image.tmdb.org/t/p/original/${profile.filePath}",
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                    placeholder: (context, url) =>
                                    const Center(child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                    const Icon(Icons.error, size: 60, color: Colors.grey),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Text(
                        "Known Works:",
                        style: Constants.theme.textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 8),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: knownList!.length,
                        itemBuilder: (context, index) {
                          final work = knownList[index];
                          final title = work.title;
                          final overView = work.overview;
                          final poster = work.posterPath;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Title: $title",
                                style: Constants.theme.textTheme.bodyMedium,
                              ),
                              Text(
                                "Overview: $overView",
                                style: Constants.theme.textTheme.bodySmall,
                              ),
                              const SizedBox(height:5),
                              SizedBox(
                                height: Constants.mediaQuery.height*0.5,
                                child: CachedNetworkImage(
                                  imageUrl: "https://image.tmdb.org/t/p/original/$poster",
                                  imageBuilder: (context, imageProvider) => Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                  const Center(child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                  const Icon(Icons.error, size: 60, color: Colors.grey),
                                ),
                              ),
                              const SizedBox(height: 8),
                            ],
                          );
                        },
                      ),


                    ],
                  ),
                );
              } else if (state is ErrorPersonProfileStates) {
                return Center(
                  child: Text('An error occurred: ${state.errorMessage}'),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}



// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:movie_assessment/core/config/constants.dart';
// import 'package:movie_assessment/features/PersonProfile/manager/cubit.dart';
// import 'package:movie_assessment/features/PersonProfile/manager/states.dart';
// import '../../../domain/models/PopularPersonModel.dart';
// import 'full_screen_image.dart';
//
// class PersonProfileScreen extends StatefulWidget {
//   final Results person;
//
//   const PersonProfileScreen({super.key, required this.person});
//
//   @override
//   State<PersonProfileScreen> createState() => _PersonProfileScreenState();
// }
//
// class _PersonProfileScreenState extends State<PersonProfileScreen> {
//   late PersonProfileCubit personProfileCubit;
//
//   @override
//   void initState() {
//     super.initState();
//     personProfileCubit = PersonProfileCubit();
//     personProfileCubit.fetchPersonProfile(widget.person.id!);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.person.name.toString()),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           color: Constants.theme.primaryColor,
//         ),
//         child: SingleChildScrollView(
//           child: BlocBuilder<PersonProfileCubit, PersonProfileStates>(
//             bloc: personProfileCubit,
//             builder: (context, state) {
//               if (state is SuccessPersonProfileStates) {
//                 var profileList = state.profile;
//                 var knownList = widget.person.knownFor;
//                 return Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Center(
//                         child: CircleAvatar(
//                           radius: 100,
//                           backgroundImage: CachedNetworkImageProvider(
//                             "${Constants.pathImage}${widget.person.profilePath}",
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       Center(
//                         child: Text(
//                           widget.person.name.toString(),
//                           style: Constants.theme.textTheme.titleLarge,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Center(
//                         child: Text(
//                           "Popularity: ${widget.person.popularity.toString()}",
//                           style: Constants.theme.textTheme.bodyMedium,
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       Text(
//                         "Profiles:",
//                         style: Constants.theme.textTheme.bodyLarge,
//                       ),
//                       const SizedBox(height: 8),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: GridView.builder(
//                           shrinkWrap: true,
//                           physics: const NeverScrollableScrollPhysics(),
//                           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             mainAxisSpacing: 10,
//                             crossAxisSpacing: 10,
//                           ),
//                           itemCount: profileList.length,
//                           itemBuilder: (context, index) {
//                             final profile = profileList[index];
//                             final aspectRatio = profile.aspectRatio;
//
//                             return GestureDetector(
//                               onTap: () {
//                                 Navigator.of(context).push(
//                                   MaterialPageRoute(
//                                     builder: (context) => FullScreenImageScreen(
//                                       imageUrl: "https://image.tmdb.org/t/p/original/${profile.filePath}",
//                                     ),
//                                   ),
//                                 );
//                               },
//                               child: AspectRatio(
//                                 aspectRatio: aspectRatio!,
//                                 child: SizedBox(
//                                   height: profile.height?.toDouble(),
//                                   width: profile.width?.toDouble(),
//                                   child: CachedNetworkImage(
//                                     imageUrl: "https://image.tmdb.org/t/p/original/${profile.filePath}",
//                                     imageBuilder: (context, imageProvider) => Container(
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         image: DecorationImage(
//                                           image: imageProvider,
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     ),
//                                     placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
//                                     errorWidget: (context, url, error) => const Icon(Icons.error, size: 60, color: Colors.grey),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                       Text(
//                         "Known Works:",
//                         style: Constants.theme.textTheme.bodyLarge,
//                       ),
//                       const SizedBox(height: 8),
//                       // List of known works
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: knownList!.length,
//                         itemBuilder: (context, index) {
//                           final work = knownList[index];
//                           final title = work.title;
//                           final overview = work.overview;
//                           final poster = work.posterPath;
//                           return Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Title: $title",
//                                 style: Constants.theme.textTheme.bodyMedium,
//                               ),
//                               Text(
//                                 "Overview: $overview",
//                                 style: Constants.theme.textTheme.bodySmall,
//                               ),
//                               SizedBox(
//                                 height: 300,
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     Navigator.of(context).push(
//                                       MaterialPageRoute(
//                                         builder: (context) => FullScreenImageScreen(
//                                           imageUrl: "https://image.tmdb.org/t/p/original/$poster",
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                   child: CachedNetworkImage(
//                                     imageUrl: "https://image.tmdb.org/t/p/original/$poster",
//                                     imageBuilder: (context, imageProvider) => Container(
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         image: DecorationImage(
//                                           image: imageProvider,
//                                           fit: BoxFit.fill,
//                                         ),
//                                       ),
//                                     ),
//                                     placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
//                                     errorWidget: (context, url, error) => const Icon(Icons.error, size: 60, color: Colors.grey),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                             ],
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 );
//               } else if (state is ErrorPersonProfileStates) {
//                 return Center(
//                   child: Text('An error occurred: ${state.errorMessage}'),
//                 );
//               } else {
//                 return const Center(child: CircularProgressIndicator());
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
