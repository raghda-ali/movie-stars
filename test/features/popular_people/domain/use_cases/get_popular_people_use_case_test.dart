import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_stars/core/exceptions/dio_exceptions.dart';
import 'package:movie_stars/features/popular_people/data/models/person_model.dart';
import 'package:movie_stars/features/popular_people/domain/entities/person_response_entity.dart';
import 'package:movie_stars/features/popular_people/domain/use_cases/get_popular_people_use_case.dart';

import '../../../../popular_people_test.mocks.dart';

void main() {
  late MockPeopleRepository mockPeopleRepository;
  late GetPopularPeopleUseCase getPopularPeopleUseCase;

  setUp(() {
    mockPeopleRepository = MockPeopleRepository();
    getPopularPeopleUseCase = GetPopularPeopleUseCase(
      peopleRepository: mockPeopleRepository,
    );
  });
  group('get popular people', () {
    const testPage = 1;
    test('should return PersonResponseEntity from repository', () async {
      //arrange
      final testResponse = PersonResponseEntity(
        page: 1,
        totalPages: 500,
        results: [
          PersonModel(id: 1, name: 'George Walton'),
          PersonModel(id: 2, name: 'Mark Richard'),
        ],
      );
      when(
        mockPeopleRepository.getPopularPeople(page: testPage),
      ).thenAnswer((_) async => Right(testResponse));
      //act
      final result = await getPopularPeopleUseCase.call(page: testPage);
      //assert
      expect(result, Right(testResponse));
      verify(mockPeopleRepository.getPopularPeople(page: testPage)).called(1);
      verifyNoMoreInteractions(mockPeopleRepository);
    });
    test('should return DioExceptions when repository fails', () async {
      // arrange
      final dioError = DioException(requestOptions: RequestOptions(path: ''));
      final expectedException = DioExceptions.fromDioError(dioError);

      when(
        mockPeopleRepository.getPopularPeople(page: testPage),
      ).thenAnswer((_) async => Left(expectedException));

      // act
      final result = await getPopularPeopleUseCase.call(page: testPage);

      // assert
      expect(result, equals(Left(expectedException)));
      verify(mockPeopleRepository.getPopularPeople(page: testPage)).called(1);
      verifyNoMoreInteractions(mockPeopleRepository);
    });
  });
}
