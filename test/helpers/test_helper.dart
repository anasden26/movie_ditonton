import 'package:core/core.dart';
import 'package:http/io_client.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  TVRepository,
  MovieRemoteDataSource,
  TVRemoteDataSource,
  MovieLocalDataSource,
  TVLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient),
  MockSpec<IOClient>(as: #MockIOClient)
])
void main() {}
