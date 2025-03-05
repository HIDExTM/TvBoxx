import 'package:freezed_annotation/freezed_annotation.dart';

import '../../typedefs.dart';

part 'performer.freezed.dart';
part 'performer.g.dart';

@Freezed(toJson: false)
class Performer with _$Performer {
  factory Performer({
    required int id,
    required String name,
    required double popularity,
    @JsonKey(name: 'original_name') required String originalName,
    @JsonKey(name: 'profile_path', defaultValue: '')
    required String profilePath, // ✅ Valor por defecto si es null
    @JsonKey(name: 'known_for_department') required String knownForDepartment,
  }) = _Performer;

  factory Performer.fromJson(Json json) => _$PerformerFromJson(json);
}
