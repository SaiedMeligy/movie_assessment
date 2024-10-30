import 'package:dio/dio.dart';
import 'package:movie_assessment/core/config/constants.dart';
import 'package:movie_assessment/data/DataSource/PersonProfile/person_pofile_data_source.dart';

class PersonProfileDataSourceImp implements PersonProfileDataSource{
  final Dio dio;

  PersonProfileDataSourceImp(this.dio);
  @override
  Future<Response> getPersonProfile(int personId) async{
    return await dio.get(
      '${Constants.baseUrl}/person/$personId/images',
      queryParameters: {
        'api_key': Constants.apiKey,
      },
    );
  }

}