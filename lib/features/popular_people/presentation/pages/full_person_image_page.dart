import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_stars/core/extensions/show_snackbar.dart';
import 'package:movie_stars/core/shared_widgets/custom_cached_network_image.dart';
import 'package:movie_stars/features/popular_people/presentation/bloc/popular_people_bloc.dart';

class FullPersonImagePage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  const FullPersonImagePage({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final popularPeopleBloc = BlocProvider.of<PopularPeopleBloc>(context);
    debugPrint('Navigated to full image page');

    return BlocListener<PopularPeopleBloc, PopularPeopleState>(
      listener: (context, state) {
        if (state.savePersonImageStatus == RequestStatus.success) {
          context.showSnackBar(
            context: context,
            message: 'Image Saved Successfully',
          );
        } else if (state.savePersonImageStatus == RequestStatus.error) {
          context.showSnackBar(
            context: context,
            message: state.savePersonImageError!,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Full Image',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.download),
              onPressed: () async {
                popularPeopleBloc.add(SavePersonImage(imageUrl: imageUrl));
              },
            ),
          ],
        ),
        backgroundColor: const Color(0xFFF5F5F5),
        body: Center(
          child: CustomCachedNetworkImage(
            imageUrl: imageUrl,
            width: width,
            height: height,
          ),
        ),
      ),
    );
  }
}
