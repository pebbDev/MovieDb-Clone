import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:moviedb/movie/models/movie_model.dart';
import 'package:moviedb/movie/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final Dio _dio;

  MovieRepositoryImpl(this._dio);

  @override
  Future<Either<String, MovieResponseModel>> getDiscover({int page = 1}) async {
    try {
      final result = await _dio.get(
        '/discover/movie',
        queryParameters: {'page': page},
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModel.fromJson(result.data);
        return Right(model);
      }
      return const Left('Error get discover Movie');
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return const Left('Another Error on get discover movies');
    }
  }
}
