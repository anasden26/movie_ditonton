import 'tv_model.dart';
import 'package:equatable/equatable.dart';

class tvResponse extends Equatable {
  final List<tvModel> tvList;

  const tvResponse({required this.tvList});

  factory tvResponse.fromJson(Map<String, dynamic> json) => tvResponse(
    tvList: List<tvModel>.from((json["results"] as List)
        .map((x) => tvModel.fromJson(x))
        .where((element) => element.posterPath != null)),
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(tvList.map((x) => x.toJson())),
  };

  @override
  List<Object> get props => [tvList];
}
