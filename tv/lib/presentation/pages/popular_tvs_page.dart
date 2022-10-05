import 'package:core/core.dart';
import '../provider/popular_tvs_notifier.dart';
import 'package:flutter/material.dart';
import '../widgets/tv_card_list.dart';
import 'package:provider/provider.dart';

class PopulartvsPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv-shows';

  @override
  _PopulartvsPageState createState() => _PopulartvsPageState();
}

class _PopulartvsPageState extends State<PopulartvsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<PopulartvsNotifier>(context, listen: false)
            .fetchPopulartvs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular TV Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PopulartvsNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.tvs[index];
                  return tvCard(tv);
                },
                itemCount: data.tvs.length,
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
    );
  }
}
