import 'package:mockito/mockito.dart';
import 'package:waaaaaaaaaa/app/domain/either/either.dart';
import 'package:waaaaaaaaaa/app/domain/models/media/media.dart';
import 'package:waaaaaaaaaa/app/domain/models/movie/movie.dart';
import 'package:waaaaaaaaaa/app/inject_repositories.dart';

import '../../../../../mocks/mocks.dart';

void stubsFavoritesSuccess() {
  when(
    Repositories.account.getFavorites(MediaType.movie),
  ).thenAnswer(
    (_) async => Right(
      {
        mockMovieMedia.id: mockMovieMedia,
      },
    ),
  );

  when(
    Repositories.account.getFavorites(MediaType.tv),
  ).thenAnswer(
    (_) async => Right(
      {
        mockSerieMedia.id: mockSerieMedia,
      },
    ),
  );
  when(
    Repositories.movies.getMovieById(mockMovieMedia.id),
  ).thenAnswer(
    (_) async => Right(
      Movie(
        id: mockMovieMedia.id,
        genres: [],
        overview: 'overview',
        runtime: 120,
        posterPath: 'posterPath',
        releaseDate: DateTime.now(),
        voteAverage: 8,
        title: 'title',
        originalTitle: 'originalTitle',
        backdropPath: 'backdropPath',
      ),
    ),
  );

  when(
    Repositories.movies.getCastByMovie(mockMovieMedia.id),
  ).thenAnswer(
    (_) async => Right([]),
  );
}
