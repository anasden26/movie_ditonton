import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/watchlist_tv_bloc.dart';

import '../../common/constants.dart';
import '../../common/state_enum.dart';
import '../../common/utils.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<WatchlistBloc>().add(OnLoad());
    context.read<WatchlistTvBloc>().add(OnLoadTv());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistBloc>().add(OnLoad());
    context.read<WatchlistTvBloc>().add(OnLoadTv());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Watchlist'),
          bottom: TabBar(
              indicatorColor: kMikadoYellow,
              tabs: [
                Tab(child: Text('Movies', style: kSubtitle,)),
                Tab(child: Text('TV Shows', style: kSubtitle,)),
              ]
          ),
        ),
        body: TabBarView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<WatchlistBloc, WatchlistState>(
                  builder: (context, state) {
                    if (state is WatchlistLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is WatchlistHasData) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          final movie = state.result[index];
                          return MovieCard(movie);
                        },
                        itemCount: state.result.length,
                      );
                    } else if (state is WatchlistError){
                      return Center(
                        key: Key('error_message'),
                        child: Text(state.message),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
                builder: (context, state) {
                  if (state is WatchlistTvLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is WatchlistTvHasData) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final tv = state.result[index];
                        return TVCard(tv);
                      },
                      itemCount: state.result.length,
                    );
                  } else if (state is WatchlistTvError){
                    return Center(
                      key: Key('error_message'),
                      child: Text(state.message),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
