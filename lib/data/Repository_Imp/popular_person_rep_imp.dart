import 'package:dio/dio.dart';
import 'package:movie_assessment/core/Failure/server_failure.dart';
import 'package:movie_assessment/data/DataSource/PopularPerson/popular_person_data_source.dart';
import '../../domain/Repository/PopularPersonRepository/popular_person_repository.dart';

class PopularPersonRepositoryImp implements PopularPersonRepository {
  final PopularPersonDataSource personDataSource;

  PopularPersonRepositoryImp(this.personDataSource);

  @override
  Future<Response> getPopularPerson({int page = 1}) async {
    try {
      final response = await personDataSource.getAllPopularPerson(page: page);
      if (response.statusCode == 200) {
        return response;
      } else {
        throw ServerFailure(
          statusCode: response.statusCode.toString(),
          message: response.data["status_message"] ?? "Unknown Error",
        );
      }
    } on DioError catch (dioError) {
      throw ServerFailure(
        statusCode: dioError.response?.statusCode.toString() ?? "",
        message: dioError.response?.data["status_message"] ?? "",
      );
    }
  }
}
