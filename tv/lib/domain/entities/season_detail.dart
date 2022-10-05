import 'package:equatable/equatable.dart';
import 'episode_detail.dart';

class SeasonDetail extends Equatable {
  const SeasonDetail({
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.id,
    required this.posterPath,
    required this.seasonNumber,
  });

  final String airDate;
  final List<EpisodeDetail> episodes;
  final String name;
  final String overview;
  final int id;
  final String? posterPath;
  final int seasonNumber;

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
