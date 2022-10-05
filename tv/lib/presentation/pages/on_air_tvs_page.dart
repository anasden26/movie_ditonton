import 'package:core/core.dart';
import '../provider/on_air_tvs_notifier.dart';
import 'package:flutter/material.dart';
import '../widgets/tv_card_list.dart';
import 'package:provider/provider.dart';

class OnAirtvsPage extends StatefulWidget {
  static const ROUTE_NAME = '/on-air-tv-shows';

  @override
  _OnAirtvsPageState createState() => _OnAirtvsPageState();
}

class _OnAirtvsPageState extends State<OnAirtvsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<OnAirtvsNotifier>(context, listen: false)
            .fetchOnAirtvs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TV Shows On Air'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<OnAirtvsNotifier>(
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
