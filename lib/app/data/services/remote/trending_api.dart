import '../../../domain/either/either.dart';
import '../../../domain/enums.dart';
import '../../../domain/failures/http_request/http_request_failure.dart';
import '../../../domain/models/media/media.dart';
import '../../../domain/models/peformer/performer.dart';
import '../../../domain/typedefs.dart';
import '../../http/http.dart';
import '../local/language_service.dart';
import '../utils/handle_failure.dart';

class TrendingAPI {
  final Http _http;
  final LanguageService _languageService;

  TrendingAPI(
    this._http,
    this._languageService,
  );

  Future<Either<HttpRequestFailure, List<Media>>> getMoviesAndSeries(
    TimeWindow timeWindow,
  ) async {
    final result = await _http.request(
      '/trending/all/${timeWindow.name}',
      languageCode: _languageService.languageCode,
      onSuccess: (json) {
        final list = List<Json>.from(json['results']);
        return getMediaList(list);
      },
    );
    return result.when(
      left: handleHttpFailure,
      right: (list) => Either.right(list),
    );
  }

  Future<Either<HttpRequestFailure, List<Performer>>> getPerformers(
      TimeWindow timeWindow) async {
    final result = await _http.request(
      '/trending/person/${timeWindow.name}',
      onSuccess: (json) {
        try {
          if (json['results'] == null) {
            return <Performer>[]; // Retornar una lista vacía en caso de null
          }

          final list = (json['results'] as List)
              .whereType<
                  Map<String, dynamic>>() // Filtra solo Map<String, dynamic>
              .where((e) =>
                  e['known_for_department'] == 'Acting' &&
                  e['profile_path'] != null)
              .map((e) => Performer.fromJson(e))
              .toList();

          return list;
        } catch (error) {
          print('$error');
          print('$json'); // 📌 Depuración

          return <Performer>[]; // ✅ Retorno corregido
        }
      },
    );

    return result.when(
      left: handleHttpFailure,
      right: (list) => Either.right(list),
    );
  }
}
