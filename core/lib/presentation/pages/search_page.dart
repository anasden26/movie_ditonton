import '../../common/constants.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                context.read<SearchBloc>().add(OnQueryChanged(query));
                context.read<SearchBlocTV>().add(OnQueryChangedTV(query));
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            DefaultTabController(
              length: 2,
              child: Expanded(
                child: Column(
                  children: [
                    TabBar(
                      indicatorColor: kMikadoYellow,
                      tabs: [
                        Tab(child: Text('Movies', style: kSubtitle,)),
                        Tab(child: Text('TV Shows', style: kSubtitle,)),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          BlocBuilder<SearchBloc, SearchState>(
                            builder: (context, state) {
                              if (state is SearchLoading) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is SearchHasData) {
                                final result = state.result;
                                return Expanded(
                                  child: ListView.builder(
                                    padding: const EdgeInsets.all(8),
                                    itemBuilder: (context, index) {
                                      final movie = result[index];
                                      return MovieCard(movie);
                                    },
                                    itemCount: result.length,
                                  ),
                                );
                              } else if (state is SearchError) {
                                return Expanded(
                                  child: Center(
                                    child: Text(state.message),
                                  ),
                                );
                              } else {
                                return Expanded(
                                  child: Container(),
                                );
                              }
                            },
                          ),
                          BlocBuilder<SearchBlocTV, SearchStateTV>(
                            builder: (context, state) {
                              if (state is SearchLoadingTV) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is SearchHasDataTV) {
                                final result = state.result;
                                return Expanded(
                                  child: ListView.builder(
                                    padding: const EdgeInsets.all(8),
                                    itemBuilder: (context, index) {
                                      final tv = result[index];
                                      return tvCard(tv);
                                    },
                                    itemCount: result.length,
                                  ),
                                );
                              } else if (state is SearchErrorTV) {
                                return Expanded(
                                  child: Center(
                                    child: Text(state.message),
                                  ),
                                );
                              } else {
                                return Expanded(
                                  child: Container(),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
