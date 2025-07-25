import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_stars/core/shared_widgets/custom_cached_network_image.dart';
import 'package:movie_stars/features/popular_people/presentation/bloc/popular_people_bloc.dart';
import 'package:movie_stars/features/popular_people/presentation/widgets/person_images_widget.dart';

class PersonDetailsPage extends StatefulWidget {
  final int personId;

  const PersonDetailsPage({super.key, required this.personId});

  @override
  State<PersonDetailsPage> createState() => _PersonDetailsPageState();
}

class _PersonDetailsPageState extends State<PersonDetailsPage> {
  @override
  void initState() {
    super.initState();
    final popularPeopleBloc = context.read<PopularPeopleBloc>();
    popularPeopleBloc.add(GetPersonDetails(personId: widget.personId));
    popularPeopleBloc.add(GetPersonImages(personId: widget.personId));
  }

  @override
  Widget build(BuildContext context) {
    final popularPeopleBloc = BlocProvider.of<PopularPeopleBloc>(context);
    return Scaffold(
      body: BlocBuilder<PopularPeopleBloc, PopularPeopleState>(
        builder: (context, state) {
          final basicInfo = popularPeopleBloc.personBasicInfo;
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                title: Text(
                  state.personBasicInfoStatus == RequestStatus.loading
                      ? "Loading.."
                      : basicInfo!.name,
                ),
              ),

              if (state.personBasicInfoStatus == RequestStatus.loading ||
                  state.personImagesStatus == RequestStatus.loading)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.grey),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.all(15.0),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      Center(
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: CustomCachedNetworkImage(
                            imageUrl:
                                basicInfo?.profilePath ??
                                'assets/images/user.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        basicInfo?.name ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        basicInfo?.knownForDepartment ?? '',
                        style: const TextStyle(fontSize: 17),
                      ),
                      const SizedBox(height: 5),
                      if (basicInfo?.birthday?.isNotEmpty == true)
                        Text('Birthday: ${basicInfo!.birthday}'),
                      const SizedBox(height: 5),
                      if (basicInfo?.placeOfBirth?.isNotEmpty == true)
                        Text('Place of birth: ${basicInfo!.placeOfBirth}'),
                      const SizedBox(height: 15),
                      if ((basicInfo?.alsoKnownAs?.isNotEmpty ?? false)) ...[
                        const Text(
                          'Also known as:',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        ...basicInfo!.alsoKnownAs!.map(
                          (name) => Text('- $name'),
                        ),
                        const SizedBox(height: 15),
                      ],

                      if ((basicInfo?.biography?.isNotEmpty ?? false)) ...[
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(basicInfo!.biography!),
                        const SizedBox(height: 15),
                      ],
                      if ((popularPeopleBloc
                              .personImagesResponse
                              ?.profiles
                              .isNotEmpty ??
                          false)) ...[
                        const Text(
                          'Images',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 10),
                        PersonImagesWidget(),
                      ],
                    ]),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
