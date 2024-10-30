import 'package:dio/dio.dart';
import 'package:movie_assessment/domain/Repository/PersonProfileRepository/person_profile_repository.dart';

class PersonProfileUseCase{
  final PersonProfileRepository personProfileRepository;
  PersonProfileUseCase(this.personProfileRepository);
  Future<Response> execute(int personId){
    return personProfileRepository.getPersonProfile(personId);
  }
}