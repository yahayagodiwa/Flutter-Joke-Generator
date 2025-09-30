import 'package:crypto_app/features/joke/domain/entities/joke_entity.dart';

class JokeResultEntity {
  final JokeEntity joke;

  const JokeResultEntity({required this.joke});

  List<Object?> get props => [joke];
}
