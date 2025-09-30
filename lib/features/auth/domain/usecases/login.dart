import 'package:crypto_app/core/errors/failures.dart';
import 'package:crypto_app/core/usecases/usecase.dart';
import 'package:crypto_app/features/auth/domain/entities/auth_result.dart';
import 'package:crypto_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class Login implements UseCase<AuthResultEntity, LoginParams> {
  final AuthRepository repository;
  Login(this.repository);

@override
  Future<Either<Failure, AuthResultEntity>> call(LoginParams params) async {
    return await repository.login(params.email, params.password);
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
