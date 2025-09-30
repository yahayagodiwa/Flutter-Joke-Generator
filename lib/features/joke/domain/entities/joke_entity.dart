import 'package:equatable/equatable.dart';

class JokeEntity extends Equatable {
  final String id;
  final String type;
  final String setup;
  final String punchline;

  const JokeEntity({
    required this.id,
    required this.type,
    required this.setup,
    required this.punchline,
  });

  @override
  List<Object?> get props => [id, type, setup, punchline];
}
