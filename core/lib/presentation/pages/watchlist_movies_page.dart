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
    Future.microtask(() =>
        Provider.of<WatchlistMovieNotifier>(context, listen: false)
            .fetchWatchlistMovies());
    Future.microtask(() =>
        Provider.of<WatchlisttvNotifier>(context, listen: false)
            .fetchWatchlisttvs());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
    Provider.of<WatchlisttvNotifier>(context, listen: false)
        .fetchWatchlisttvs();
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
                child: Consumer<WatchlistMovieNotifier>(
                  builder: (context, data, child) {
                    if (data.watchlistState == RequestState.loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (data.watchlistState == RequestState.loaded) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          final movie = data.watchlistMovies[index];
                          return MovieCard(movie);
                        },
                        itemCount: data.watchlistMovies.length,
                      );
                    } else {
                      return Center(
                        key: Key('error_message'),
                        child: Text(data.message),
                      );
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<WatchlisttvNotifier>(
                builder: (context, data, child) {
                  if (data.watchlistState == RequestState.loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (data.watchlistState == RequestState.loaded) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final tv = data.watchlisttvs[index];
                        return tvCard(tv);
                      },
                      itemCount: data.watchlisttvs.length,
                    );
                  } else {
                    return Center(
                      key: Key('error_message'),
                      child: Text(data.message),
                    );
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
