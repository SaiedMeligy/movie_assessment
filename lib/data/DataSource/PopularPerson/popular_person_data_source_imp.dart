import 'package:dio/dio.dart';
import 'package:movie_assessment/core/config/constants.dart';
import 'package:movie_assessment/data/DataSource/PopularPerson/popular_person_data_source.dart';

class PopularPersonDataSourceImp implements PopularPersonDataSource {
  final Dio dio;

  PopularPersonDataSourceImp(this.dio);

  @override
  Future<Response> getAllPopularPerson({int page = 1}) async {
    return await dio.get(
      '${Constants.baseUrl}/person/popular',
      queryParameters: {
        'api_key': Constants.apiKey,
        'page': page,
      },
    );
  }
}
