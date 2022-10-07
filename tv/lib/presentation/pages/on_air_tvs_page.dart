import 'package:core/common/state_enum.dart';
import 'package:tv/presentation/provider/on_air_tvs_notifier.dart';
import 'package:flutter/material.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';
import 'package:provider/provider.dart';

class OnAirTVsPage extends StatefulWidget {
  static const ROUTE_NAME = '/on-air-tv-shows';

  @override
  _OnAirTVsPageState createState() => _OnAirTVsPageState();
}

class _OnAirTVsPageState extends State<OnAirTVsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<OnAirTVsNotifier>(context, listen: false)
            .fetchOnAirTVs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TV Shows On Air'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<OnAirTVsNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.tvs[index];
                  return TVCard(tv);
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
