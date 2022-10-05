import 'package:core/core.dart';
import 'package:movie/movie.dart';
import 'package:tv/tv.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  MovieRepository,
  tvRepository,
  MovieRemoteDataSource,
  tvRemoteDataSource,
  MovieLocalDataSource,
  tvLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
