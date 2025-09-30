import 'package:crypto_app/core/errors/failures.dart';
import 'package:crypto_app/features/joke/domain/entities/joke_result_entity.dart';
import 'package:dartz/dartz.dart';

abstract class JokeRepository {
  Future<Either<Failure, JokeResultEntity>> getJoke();
}
