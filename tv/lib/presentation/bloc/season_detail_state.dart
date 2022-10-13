part of 'season_detail_bloc.dart';

abstract class SeasonDetailStateTv extends Equatable {
  const SeasonDetailStateTv();

  @override
  List<Object> get props => [];
}

class SeasonDetailEmptyTv extends SeasonDetailStateTv {}

class SeasonDetailLoadingTv extends SeasonDetailStateTv {}

class SeasonDetailErrorTv extends SeasonDetailStateTv {
  final String message;

  SeasonDetailErrorTv(this.message);

  @override
  List<Object> get props => [message];
}

class SeasonDetailHasDataTv extends SeasonDetailStateTv {
  final SeasonDetail result;

  SeasonDetailHasDataTv(this.result);

  @override
  List<Object> get props => [result];
}