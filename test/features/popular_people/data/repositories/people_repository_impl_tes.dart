import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_stars/features/popular_people/data/models/person_model.dart';
import 'package:movie_stars/features/popular_people/data/models/person_response_model.dart';
import 'package:movie_stars/features/popular_people/data/repositories/people_repository_impl.dart';
import '../../../../popular_people_test.mocks.dart';

void main() {
  late PeopleRepositoryImpl peopleRepositoryImpl;
  late MockPeopleRemoteDataSource mockRemoteDataSource;
  late MockPeopleLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockPeopleRemoteDataSource();
    mockLocalDataSource = MockPeopleLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    peopleRepositoryImpl = PeopleRepositoryImpl(
      peopleRemoteDataSource: mockRemoteDataSource,
      peopleLocalDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getPopularPeople', () {
    const testPage = 1;
    final testResponse = PersonResponseModel(
      results: [
        PersonModel(id: 1, name: 'George Walton'),
        PersonModel(id: 2, name: 'Mark Richard'),
      ],
      page: 1,
      totalPages: 10,
    );

    test('should return remote data when online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(
        mockRemoteDataSource.getPopularPeople(page: testPage),
      ).thenAnswer((_) async => testResponse);
      when(
        mockLocalDataSource.cachePopularPeople(testResponse, testPage),
      ).thenAnswer((_) async {});
      // act
      final result = await peopleRepositoryImpl.getPopularPeople(
        page: testPage,
      );
      // assert
      expect(result, Right(testResponse));
      verify(mockRemoteDataSource.getPopularPeople(page: testPage)).called(1);
      verify(
        mockLocalDataSource.cachePopularPeople(testResponse, testPage),
      ).called(1);
    });

    test('should return cached data when offline', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(
        mockLocalDataSource.getCachedPopularPeople(testPage),
      ).thenAnswer((_) async => testResponse);
      // act
      final result = await peopleRepositoryImpl.getPopularPeople(
        page: testPage,
      );
      // assert
      expect(result, Right(testResponse));
      verify(mockLocalDataSource.getCachedPopularPeople(testPage)).called(1);
    });
  });

  group('getPersonDetails', () {
    const testId = 60959;
    final testPerson = PersonModel(id: 60959, name: 'Jackie Sandler');

    test('should return person details', () async {
      // arrange
      when(
        mockRemoteDataSource.getPersonDetails(personId: testId),
      ).thenAnswer((_) async => testPerson);
      // act
      final result = await peopleRepositoryImpl.getPersonDetails(
        personId: testId,
      );
      // assert
      expect(result, Right(testPerson));
      verify(mockRemoteDataSource.getPersonDetails(personId: testId)).called(1);
    });
  });
}
