import 'dart:io';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import '../datasources/tv_local_data_source.dart';
import '../datasources/tv_remote_data_source.dart';
import '../models/tv_table.dart';
import '../../domain/entities/season_detail.dart';
import '../../domain/entities/tv.dart';
import '../../domain/entities/tv_detail.dart';
import '../../domain/repositories/tv_repository.dart';

class tvRepositoryImpl implements tvRepository {
  final tvRemoteDataSource remoteDataSource;
  final tvLocalDataSource localDataSource;

  tvRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<tv>>> gettvOnTheAir() async {
    try {
      final result = await remoteDataSource.gettvOnTheAir();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, tvDetail>> gettvDetail(int id) async {
    try {
      final result = await remoteDataSource.gettvDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<tv>>> gettvRecommendations(int id) async {
    try {
      final result = await remoteDataSource.gettvRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<tv>>> getPopulartvs() async {
    try {
      final result = await remoteDataSource.getPopulartvs();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<tv>>> getTopRatedtvs() async {
    try {
      final result = await remoteDataSource.getTopRatedtvs();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<tv>>> searchtvs(String query) async {
    try {
      final result = await remoteDataSource.searchtvs(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(tvDetail tv) async {
    try {
      final result =
      await localDataSource.insertWatchlist(tvTable.fromEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(tvDetail tv) async {
    try {
      final result =
      await localDataSource.removeWatchlist(tvTable.fromEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.gettvById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<tv>>> getWatchlisttv() async {
    final result = await localDataSource.getWatchlisttv();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<Either<Failure, SeasonDetail>> getSeasonDetail(int id, int season) async {
    try {
      final result = await remoteDataSource.getSeasonDetail(id, season);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
