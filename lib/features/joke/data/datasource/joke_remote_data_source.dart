import 'package:crypto_app/core/errors/exceptions.dart';
import 'package:crypto_app/features/joke/data/models/joke_model.dart';

import 'package:dio/dio.dart';

abstract class JokeRemoteDataSource {
  Future<JokeModel> getJokes();
}

class JokeRemoteDataSourceImpl implements JokeRemoteDataSource {
  final Dio client;

  JokeRemoteDataSourceImpl({required this.client}); 

  @override
  Future<JokeModel> getJokes() async { 
    await Future.delayed(const Duration(seconds: 3));
    try {
      final response = await client.get('/random_joke'); 
      final data = response.data;
      return JokeModel.fromJson(data); 
    } on DioException catch (e) {
      throw ServerException(e.message);
    }
  }
}