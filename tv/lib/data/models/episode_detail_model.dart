import 'package:tv/domain/entities/episode_detail.dart';

class EpisodeDetailResponse {
  EpisodeDetailResponse({
    required this.airDate,
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.seasonNumber,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  final String airDate;
  final int episodeNumber;
  final int id;
  final String name;
  final String overview;
  final String? productionCode;
  final int seasonNumber;
  final String? stillPath;
  final double voteAverage;
  final int voteCount;

  factory EpisodeDetailResponse.fromJson(Map<String, dynamic> json) =>
      EpisodeDetailResponse(
        airDate: json["air_date"] ?? '',
        episodeNumber: json["episode_number"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        productionCode: json["production_code"],
        seasonNumber: json["season_number"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  EpisodeDetail toEntity() {
    return EpisodeDetail(
      airDate: this.airDate,
      episodeNumber: this.episodeNumber,
      name: this.name,
      overview: this.overview,
      id: this.id,
      productionCode: this.productionCode,
      seasonNumber: this.seasonNumber,
      stillPath: this.stillPath,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
    );
  }
}