import '../../domain/entities/tv.dart';
import 'package:equatable/equatable.dart';

class tvModel extends Equatable {
  const tvModel({
    required this.posterPath,
    required this.popularity,
    required this.id,
    required this.backdropPath,
    required this.voteAverage,
    required this.overview,
    required this.firstAirDate,
    required this.originalCountry,
    required this.genreIds,
    required this.originalLanguage,
    required this.voteCount,
    required this.name,
    required this.originalName,
  });

  final String? posterPath;
  final double popularity;
  final int id;
  final String? backdropPath;
  final double voteAverage;
  final String overview;
  final String? firstAirDate;
  final List<String> originalCountry;
  final List<int> genreIds;
  final String originalLanguage;
  final int voteCount;
  final String name;
  final String originalName;

  factory tvModel.fromJson(Map<String, dynamic> json) => tvModel(
    posterPath: json["poster_path"],
    popularity: json["popularity"].toDouble(),
    id: json["id"],
    backdropPath: json["backdrop_path"],
    voteAverage: json["vote_average"].toDouble(),
    overview: json["overview"],
    firstAirDate: json["first_air_date"],
    originalCountry: List<String>.from(json["origin_country"].map((x) => x)),
    genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
    originalLanguage: json["original_language"],
    voteCount: json["vote_count"],
    name: json["name"],
    originalName: json["original_name"],
  );

  Map<String, dynamic> toJson() => {
    "poster_path": posterPath,
    "popularity": popularity,
    "id": id,
    "backdrop_path": backdropPath,
    "vote_average": voteAverage,
    "overview": overview,
    "first_air_date": firstAirDate,
    "origin_country": List<dynamic>.from(originalCountry.map((x) => x)),
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "original_language": originalLanguage,
    "vote_count": voteCount,
    "name": name,
    "original_name": originalName,
  };

  tv toEntity() {
    return tv(
      posterPath: posterPath,
      popularity: popularity,
      id: id,
      backdropPath: backdropPath,
      voteAverage: voteAverage,
      overview: overview,
      firstAirDate: firstAirDate,
      originalCountry: originalCountry,
      genreIds: genreIds,
      originalLanguage: originalLanguage,
      voteCount: voteCount,
      name: name,
      originalName: originalName,
    );
  }

  @override
  List<Object?> get props => [
    posterPath,
    popularity,
    id,
    backdropPath,
    voteAverage,
    overview,
    firstAirDate,
    originalCountry,
    genreIds,
    originalLanguage,
    voteCount,
    name,
    originalName,
  ];
}
