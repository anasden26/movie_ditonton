import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/on_air_tv_bloc.dart';
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
    context.read<OnAirTvBloc>().add(fetchOnAirTvs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TV Shows On Air'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<OnAirTvBloc, OnAirTvState>(
          builder: (context, state) {
            if (state is OnAirTvLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is OnAirTvHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.result[index];
                  return TVCard(tv);
                },
                itemCount: state.result.length,
              );
            } else if (state is OnAirTvError) {
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
    );
  }
}
