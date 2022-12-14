import 'package:equatable/equatable.dart';
import 'package:tv/data/models/episode_detail_model.dart';
import 'package:tv/domain/entities/season_detail.dart';

class SeasonDetailResponse extends Equatable {
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

  Map<String, dynamic> toJson() => {
    "air_date": airDate,
    "episodes": List<dynamic>.from(episodes.map((x) => x.toJson())),
    "name": name,
    "overview": overview,
    "id": id,
    "poster_path": posterPath,
    "season_number": seasonNumber,
  };

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

  @override
  List<Object?> get props => [
    airDate,
    episodes,
    name,
    overview,
    id,
    posterPath,
    seasonNumber,
  ];
}