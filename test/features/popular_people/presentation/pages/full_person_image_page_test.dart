import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_stars/core/shared_widgets/custom_cached_network_image.dart';
import 'package:movie_stars/features/popular_people/presentation/pages/full_person_image_page.dart';
import 'package:movie_stars/features/popular_people/presentation/bloc/popular_people_bloc.dart';
import 'package:network_image_mock/network_image_mock.dart';
import '../../../../popular_people_test.mocks.dart';

void main() {
  late MockPopularPeopleBloc mockBloc;
  const testImageUrl = 'image.jpg';
  const testWidth = 150.0;
  const testHeight = 300.0;
  Widget buildTestWidget() {
    return MaterialApp(
      home: BlocProvider<PopularPeopleBloc>.value(
        value: mockBloc,
        child: const FullPersonImagePage(
          imageUrl: testImageUrl,
          width: testWidth,
          height: testHeight,
        ),
      ),
    );
  }

  setUp(() {
    mockBloc = MockPopularPeopleBloc();
    when(mockBloc.state).thenReturn(
      PopularPeopleState(popularPeopleStatus: RequestStatus.initial),
    );
    when(mockBloc.stream).thenAnswer((_) => Stream.empty());
  });

  group('FullPersonImagePage Widget Tests', () {
    testWidgets(
      'renders FullPersonImagePage with the provided image and dispatches SavePersonImage event when the download button is tapped',
      (WidgetTester tester) async {
        // act
        await tester.pumpWidget(buildTestWidget());
        expect(find.text('Full Image'), findsOneWidget);
        expect(
          find.byWidgetPredicate((widget) {
            if (widget is CustomCachedNetworkImage) {
              return widget.imageUrl == testImageUrl;
            }
            return false;
          }),
          findsOneWidget,
        );
        // assert
        expect(find.byIcon(Icons.download), findsOneWidget);
        await tester.tap(find.byIcon(Icons.download));
        await tester.pump();
        verify(mockBloc.add(SavePersonImage(imageUrl: testImageUrl))).called(1);
      },
    );

    testWidgets('shows snack bar on success state', (
      WidgetTester tester,
    ) async {
      // arrange
      final successState = PopularPeopleState(
        savePersonImageStatus: RequestStatus.success,
        savePersonImageError: null,
      );
      when(mockBloc.state).thenReturn(successState);
      when(mockBloc.stream).thenAnswer((_) => Stream.value(successState));
      // act
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(buildTestWidget());
        await tester.pump();
        // assert
        expect(find.text('Image Saved Successfully'), findsOneWidget);
      });
    });

    testWidgets('shows snack bar on error state', (WidgetTester tester) async {
      const errorMessage = 'Failed to save image';
      // arrange
      final errorState = PopularPeopleState(
        savePersonImageStatus: RequestStatus.error,
        savePersonImageError: errorMessage,
      );
      when(mockBloc.state).thenReturn(errorState);
      when(mockBloc.stream).thenAnswer((_) => Stream.value(errorState));
      // act
      await mockNetworkImagesFor(() async {
        await tester.pumpWidget(buildTestWidget());
        await tester.pump();
        // assert
        expect(find.text(errorMessage), findsOneWidget);
      });
    });
  });
}
