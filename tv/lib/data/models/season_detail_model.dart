import 'package:tv/data/models/episode_detail_model.dart';
import 'package:tv/domain/entities/season_detail.dart';

class SeasonDetailResponse {
  SeasonDetailResponse({
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.id,
    required this.posterPath,
    required this.seasonNumber,
  });

  final String airDate;
  final List<EpisodeDetailResponse> episodes;
  final String name;
  final String overview;
  final int id;
  final String posterPath;
  final int seasonNumber;

  factory SeasonDetailResponse.fromJson(Map<String, dynamic> json) =>
      SeasonDetailResponse(
        airDate: json["air_date"] ?? '',
        episodes: List<EpisodeDetailResponse>.from(
            json["episodes"].map((x) => EpisodeDetailResponse.fromJson(x))),
        name: json["name"],
        overview: json["overview"],
        id: json["id"],
        posterPath: json["poster_path"] ?? '',
        seasonNumber: json["season_number"],
      );

  SeasonDetail toEntity() {
    return SeasonDetail(
      airDate: this.airDate,
      episodes: this.episodes.map((episode) => episode.toEntity()).toList(),
      name: this.name,
      overview: this.overview,
      id: this.id,
      posterPath: this.posterPath,
      seasonNumber: this.seasonNumber,
    );
  }
}