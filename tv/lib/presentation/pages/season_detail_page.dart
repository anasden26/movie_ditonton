import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:core/common/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/season_detail_bloc.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class SeasonDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-season';

  final int id;
  final int season;
  SeasonDetailPage({required this.id, required this.season});

  @override
  _SeasonDetailPageState createState() => _SeasonDetailPageState();
}

class _SeasonDetailPageState extends State<SeasonDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<SeasonDetailBlocTv>().add(fetchSeasonDetail(widget.id, widget.season));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SeasonDetailBlocTv, SeasonDetailStateTv>(
        builder: (context, state) {
          if (state is SeasonDetailLoadingTv) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SeasonDetailHasDataTv) {
            final screenWidth = MediaQuery.of(context).size.width;
            return SafeArea(
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: 'https://image.tmdb.org/t/p/w500${state.result.posterPath}',
                    width: screenWidth,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 48 + 8),
                    child: DraggableScrollableSheet(
                      builder: (context, scrollController) {
                        return Container(
                          decoration: BoxDecoration(
                            color: kRichBlack,
                            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                          ),
                          padding: const EdgeInsets.only(
                            left: 16,
                            top: 16,
                            right: 16,
                          ),
                          child: Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 16),
                                child: SingleChildScrollView(
                                  controller: scrollController,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8),
                                        child: Text(
                                          state.result.name,
                                          style: kHeading6,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 8),
                                        child: Text(
                                          state.result.overview,
                                          style: kBodyText,
                                        ),
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        itemCount: state.result.episodes.length,
                                        itemBuilder: (context, index) {
                                          var episode = state.result.episodes[index];
                                          return ListTile(
                                            contentPadding: const EdgeInsets.symmetric(vertical: 4),
                                            leading: CachedNetworkImage(
                                              imageUrl: 'https://image.tmdb.org/t/p/w500${episode.stillPath}',
                                              width: 100,
                                              placeholder: (context, url) => Center(
                                                child: CircularProgressIndicator(),
                                              ),
                                              errorWidget: (context, url, error) => Icon(Icons.error),
                                            ),
                                            title: Text(
                                              '#${episode.episodeNumber} ${episode.name}',
                                              style: const TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                            subtitle: ReadMoreText(
                                              episode.overview,
                                              style: kBodyText,
                                              trimLines: 4,
                                              colorClickableText: kMikadoYellow,
                                              trimMode: TrimMode.Line,
                                              trimCollapsedText: 'Show more',
                                              trimExpandedText: 'Show less',
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  color: Colors.white,
                                  height: 4,
                                  width: 48,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      // initialChildSize: 0.5,
                      minChildSize: 0.25,
                      // maxChildSize: 1.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: kRichBlack,
                      foregroundColor: Colors.white,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          } else if (state is SeasonDetailErrorTv) {
            return Center(
              key: Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}