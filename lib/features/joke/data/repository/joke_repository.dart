import 'package:crypto_app/core/errors/failures.dart';
import 'package:crypto_app/features/joke/data/datasource/joke_remote_data_source.dart';
import 'package:crypto_app/features/joke/domain/entities/joke_result_entity.dart';
import 'package:crypto_app/features/joke/domain/repository/joke_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class JokeRepositoryImpl implements JokeRepository { 
  final JokeRemoteDataSource jokeDataSource;

  JokeRepositoryImpl({required this.jokeDataSource});

  @override
  Future<Either<Failure, JokeResultEntity>> getJoke() async { 
    try {
      final jokeModel = await jokeDataSource.getJokes();
      return Right(JokeResultEntity(joke: jokeModel));
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          message: e.response?.data['message'] ?? e.message ?? 'Failed to fetch Joke',
        ), 
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString())); 
    }
  }
}