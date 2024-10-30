import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:movie_assessment/data/DataSource/PersonProfile/person_pofile_data_source.dart';
import 'package:movie_assessment/domain/Repository/PersonProfileRepository/person_profile_repository.dart';

import '../../core/Failure/server_failure.dart';

class PersonProfileRepositoryImp implements PersonProfileRepository{
  final PersonProfileDataSource profileDataSource;

  PersonProfileRepositoryImp(this.profileDataSource);
  @override
  Future<Response> getPersonProfile(int personId) async{
    try{
      final response = await profileDataSource.getPersonProfile(personId);
      if(response.statusCode==200){
        return response;
      }
      else{
        throw ServerFailure(
          statusCode: response.statusCode.toString(),
          message: response.data["status_message"] ?? "Unknown Error",
        );

      }

    }on DioException catch(dioException){
      throw ServerFailure(
        statusCode: dioException.response?.statusCode.toString()?? "Unknown Error",
        message: dioException.message,
      );

    }

  }

}