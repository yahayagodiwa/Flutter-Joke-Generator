import 'package:crypto_app/core/errors/failures.dart';
import 'package:crypto_app/features/joke/domain/entities/joke_entity.dart';
import 'package:crypto_app/features/joke/domain/usecases/get_joke.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "joke_event.dart";
part 'joke_state.dart';

class JokeBloc extends Bloc<JokeEvent, JokeState> {
  final GetJoke getJoke;

  JokeBloc({required this.getJoke}) : super(JokeInitial()) {
    on<JokeRequested>(_onJokeRequested);
  }

  Future<void> _onJokeRequested(
    JokeRequested event,
    Emitter<JokeState> emit,
  ) async {
    emit(JokeLoading());

    final result = await getJoke(
      GetJokeParams(
        id: event.id,
        type: event.type,
        setup: event.setup,
        punchline: event.punchline,
      ),
    );

    result.fold(
      (failure) => emit(JokeError(message: _mapFailureToMessage(failure))),
      (joke) => emit(JokeFetched(joke: joke.joke)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return (failure as ServerFailure).message;
      default:
        return 'Unexpected error';
    }
  }
}
