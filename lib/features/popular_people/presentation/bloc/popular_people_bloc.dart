import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_stars/features/popular_people/domain/entities/person_entity.dart';
import 'package:movie_stars/features/popular_people/domain/entities/person_images_response_entity.dart';
import 'package:movie_stars/features/popular_people/domain/use_cases/get_person_details_use_case.dart';
import 'package:movie_stars/features/popular_people/domain/use_cases/get_person_images_use_case.dart';
import 'package:movie_stars/features/popular_people/domain/use_cases/get_popular_people_use_case.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saver_gallery/saver_gallery.dart';

part 'popular_people_event.dart';
part 'popular_people_state.dart';

class PopularPeopleBloc extends Bloc<PopularPeopleEvent, PopularPeopleState> {
  final GetPopularPeopleUseCase getPopularPeopleUseCase;
  final GetPersonDetailsUseCase getPersonBasicInfoUseCase;
  final GetPersonImagesUseCase getPersonImagesUseCase;
  List<PersonEntity> popularPeople = [];
  List<PersonEntity> loadedPopularPeople = [];
  bool hasMorePeople = true;
  int currentPopularPeoplePage = 2;
  PersonEntity? personBasicInfo;
  PersonImagesResponseEntity? personImagesResponse;
  PopularPeopleBloc({
    required this.getPopularPeopleUseCase,
    required this.getPersonBasicInfoUseCase,
    required this.getPersonImagesUseCase,
  }) : super(const PopularPeopleState()) {
    Future<bool> requestPermissionToGallery() async {
      if (Platform.isAndroid) {
        if (await Permission.photos.isGranted ||
            await Permission.storage.isGranted) {
          return true;
        }
        var status = await Permission.photos.request();
        if (!status.isGranted) {
          status = await Permission.storage.request();
        }
        return status.isGranted;
      }
      return true;
    }

    on<GetPopularPeople>((event, emit) async {
      emit(state.copyWith(popularPeopleStatus: RequestStatus.loading));

      final errorOrDone = await getPopularPeopleUseCase(page: event.page);
      errorOrDone.fold(
        (error) {
          emit(
            state.copyWith(
              popularPeopleStatus: RequestStatus.error,
              popularPeopleError: error.toString(),
            ),
          );
        },
        (done) {
          popularPeople = done;
          emit(state.copyWith(popularPeopleStatus: RequestStatus.success));
          },
      );
    });
    on<LoadMorePopularPeople>((event, emit) async {
      emit(state.copyWith(loadMoreStatus: RequestStatus.loading));
      final errorOrDone = await getPopularPeopleUseCase(page: event.page);
      errorOrDone.fold(
        (error) {
          emit(
            state.copyWith(
              loadMoreStatus: RequestStatus.error,
              loadMoreError: error.toString(),
            ),
          );
        },
        (done) {
          loadedPopularPeople = done;
        },
      );
      final Set<int> currentPopularPeopleIds =
          popularPeople.map((person) => person.id).toSet();
      final allLoadedPopularPeople = loadedPopularPeople.where(
        (event) => !currentPopularPeopleIds.contains(event.id),
      );

      popularPeople.addAll(allLoadedPopularPeople);
      currentPopularPeoplePage++;
      if (popularPeople.length < 15) {
        hasMorePeople = false;
      }
      emit(state.copyWith(loadMoreStatus: RequestStatus.success));
    });
    on<GetPersonDetails>((event, emit) async {
      emit(state.copyWith(personBasicInfoStatus: RequestStatus.loading));
      final errorOrDone = await getPersonBasicInfoUseCase(
        personId: event.personId,
      );
      errorOrDone.fold(
        (error) {
          emit(
            state.copyWith(
              personBasicInfoStatus: RequestStatus.error,
              personBasicInfoError: error.toString(),
            ),
          );
        },
        (done) {
          personBasicInfo = done;
          emit(state.copyWith(personBasicInfoStatus: RequestStatus.success));
        },
      );
    });

    on<GetPersonImages>((event, emit) async {
      emit(state.copyWith(personImagesStatus: RequestStatus.loading));

      final errorOrDone = await getPersonImagesUseCase(
        personId: event.personId,
      );
      errorOrDone.fold(
        (error) {
          emit(
            state.copyWith(
              personImagesStatus: RequestStatus.error,
              personImagesError: error.toString(),
            ),
          );
        },
        (done) {
          personImagesResponse = done;
          emit(state.copyWith(personImagesStatus: RequestStatus.success));
        },
      );
    });
    on<SavePersonImage>((event, emit) async {
      bool isGranted = await requestPermissionToGallery();
      if (!isGranted) {
        emit(
          state.copyWith(
            savePersonImageStatus: RequestStatus.error,
            savePersonImageError: 'Permission not granted',
          ),
        );
        return;
      }

      try {
        var response = await Dio().get(
          "https://image.tmdb.org/t/p/w500${event.imageUrl}",
          options: Options(responseType: ResponseType.bytes),
        );

        String imageName = "saved_image.jpg";

        await SaverGallery.saveImage(
          Uint8List.fromList(response.data),
          quality: 60,
          fileName: imageName,
          androidRelativePath: "Pictures/MovieStars/PopularPeople",
          skipIfExists: false,
        );

        emit(state.copyWith(savePersonImageStatus: RequestStatus.success));
      } catch (e) {
        emit(
          state.copyWith(
            savePersonImageStatus: RequestStatus.error,
            savePersonImageError: e.toString(),
          ),
        );
      }
    });
  }
}
