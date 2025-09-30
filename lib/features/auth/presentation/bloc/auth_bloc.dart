import 'package:crypto_app/core/errors/failures.dart';
import 'package:crypto_app/features/auth/domain/entities/auth_result.dart';
import 'package:crypto_app/features/auth/domain/usecases/login.dart';
import 'package:crypto_app/features/auth/domain/usecases/register.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Register register;
  final Login login;

  AuthBloc({required this.register, required this.login})
    : super(AuthInitial()) {
    on<RegisterRequested>(_onRegisterRequested);
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final Either<Failure, AuthResultEntity> result = await register(
      RegisterParams(name: event.name, email: event.email, password: event.password)
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (authResult) => emit(AuthAuthenticated(authResult.user)),
    );
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final Either<Failure, AuthResultEntity> result = await login(
      LoginParams(email: event.email, password: event.password)
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (authResult) => emit(AuthAuthenticated(authResult.user)),
    );
  }
}