// lib/core/di/injection_container.dart
import 'package:crypto_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:crypto_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:crypto_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:crypto_app/features/auth/domain/usecases/login.dart';
import 'package:crypto_app/features/auth/domain/usecases/register.dart';
import 'package:crypto_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:crypto_app/features/joke/data/datasource/joke_remote_data_source.dart';
import 'package:crypto_app/features/joke/data/repository/joke_repository.dart';
import 'package:crypto_app/features/joke/domain/repository/joke_repository.dart';
import 'package:crypto_app/features/joke/domain/usecases/get_joke.dart';
import 'package:crypto_app/features/joke/presentation/bloc/joke_bloc.dart';

import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // ---------- External ----------
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);

  // Auth API client
  sl.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: 'https://blog-app-oeay.onrender.com',
        connectTimeout: const Duration(seconds: 5),
      ),
    ),
  );

  // Joke API client (named instance)
  sl.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: 'https://official-joke-api.appspot.com',
        connectTimeout: const Duration(seconds: 5),
      ),
    ),
    instanceName: 'jokeApi',
  );

  // ---------- Data sources ----------
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl<Dio>()),
  );

  sl.registerLazySingleton<JokeRemoteDataSource>(
    () => JokeRemoteDataSourceImpl(client: sl<Dio>(instanceName: 'jokeApi')),
  );

  // ---------- Repositories ----------
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl<AuthRemoteDataSource>(),
      prefs: sl<SharedPreferences>(),
    ),
  );

  sl.registerLazySingleton<JokeRepository>(
    () => JokeRepositoryImpl(jokeDataSource: sl<JokeRemoteDataSource>()),
  );

  // ---------- Usecases ----------
  sl.registerLazySingleton<Register>(
    () => Register(sl<AuthRepository>()),
  );

  sl.registerLazySingleton<Login>(
    () => Login(sl<AuthRepository>()),
  );

  sl.registerLazySingleton<GetJoke>(
    () => GetJoke(sl<JokeRepository>()),
  );

  // ---------- Blocs ----------
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      register: sl<Register>(),
      login: sl<Login>(),
    ),
  );

  sl.registerFactory<JokeBloc>(
    () => JokeBloc(getJoke: sl<GetJoke>()),
  );
}
