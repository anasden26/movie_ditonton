import 'package:core/core.dart';
import '../models/tv_table.dart';

abstract class tvLocalDataSource {
  Future<String> insertWatchlist(tvTable tv);
  Future<String> removeWatchlist(tvTable tv);
  Future<tvTable?> gettvById(int id);
  Future<List<tvTable>> getWatchlisttv();
}

class tvLocalDataSourceImpl implements tvLocalDataSource {
  final DatabaseHelper databaseHelper;

  tvLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(tvTable tv) async {
    try {
      await databaseHelper.insertWatchlisttv(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(tvTable tv) async {
    try {
      await databaseHelper.removeWatchlisttv(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<tvTable?> gettvById(int id) async {
    final result = await databaseHelper.gettvById(id);
    if (result != null) {
      return tvTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<tvTable>> getWatchlisttv() async {
    final result = await databaseHelper.getWatchlisttv();
    return result.map((data) => tvTable.fromMap(data)).toList();
  }
}
