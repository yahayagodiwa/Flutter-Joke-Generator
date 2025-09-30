import 'package:crypto_app/core/errors/failures.dart';
import 'package:crypto_app/core/usecases/usecase.dart';
import 'package:crypto_app/features/joke/domain/entities/joke_result_entity.dart';
import 'package:crypto_app/features/joke/domain/repository/joke_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';


class GetJoke implements UseCase<JokeResultEntity, GetJokeParams> {
  final JokeRepository repository;
  GetJoke(this.repository);

  @override
  Future<Either<Failure, JokeResultEntity>> call(
    GetJokeParams params,
  ) async {
    return await repository.getJoke();
  }
}


class GetJokeParams extends Equatable {
  final String id;
  final String type;
  final String setup;
  final String punchline;

  const GetJokeParams({
    required this.id,
    required this.type,
    required this.setup,
    required this.punchline,
  });

  @override
  List<Object?> get props => [id, type, setup, punchline];
}
