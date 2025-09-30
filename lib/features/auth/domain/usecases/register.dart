import 'package:crypto_app/core/errors/failures.dart';
import 'package:crypto_app/core/usecases/usecase.dart';
import 'package:crypto_app/features/auth/domain/entities/auth_result.dart';
import 'package:crypto_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class Register implements UseCase<AuthResultEntity, RegisterParams> {
  final AuthRepository repository;
  Register(this.repository);

  @override
  Future<Either<Failure, AuthResultEntity>> call(RegisterParams params) async{
    return await repository.register(params.name, params.email, params.password);
  }
}

class RegisterParams extends Equatable {
  final String name;
  final String email;
  final String password;

  const RegisterParams({required this.name, required this.email, required this.password});

  @override
  List<Object?> get props => [name, email, password];
}
