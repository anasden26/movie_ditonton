part of 'season_detail_bloc.dart';

abstract class SeasonDetailEventTv {
  const SeasonDetailEventTv();
}

class fetchSeasonDetail extends SeasonDetailEventTv {
  final int id;
  final int season;

  fetchSeasonDetail(this.id, this.season);
}