import 'package:tv/data/models/tv_model.dart';
import 'package:equatable/equatable.dart';

class TVResponse extends Equatable {
  final List<TVModel> TVList;

  TVResponse({required this.TVList});

  factory TVResponse.fromJson(Map<String, dynamic> json) => TVResponse(
    TVList: List<TVModel>.from((json["results"] as List)
        .map((x) => TVModel.fromJson(x))
        .where((element) => element.posterPath != null)),
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(TVList.map((x) => x.toJson())),
  };

  @override
  List<Object> get props => [TVList];
}
