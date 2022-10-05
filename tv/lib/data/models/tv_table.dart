import '../../domain/entities/tv.dart';
import '../../domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class tvTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  const tvTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  factory tvTable.fromEntity(tvDetail tv) => tvTable(
    id: tv.id,
    name: tv.name,
    posterPath: tv.posterPath,
    overview: tv.overview,
  );

  factory tvTable.fromMap(Map<String, dynamic> map) => tvTable(
    id: map['id'],
    name: map['name'],
    posterPath: map['posterPath'],
    overview: map['overview'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'posterPath': posterPath,
    'overview': overview,
  };

  tv toEntity() => tv.watchlist(
    id: id,
    overview: overview,
    posterPath: posterPath,
    name: name,
  );

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, posterPath, overview];
}
