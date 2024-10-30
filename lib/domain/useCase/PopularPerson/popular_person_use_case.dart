import 'package:dio/dio.dart';
import 'package:movie_assessment/domain/Repository/PopularPersonRepository/popular_person_repository.dart';

class PopularPersonUseCase {
  final PopularPersonRepository personRepository;

  PopularPersonUseCase(this.personRepository);

  Future<Response> execute({int page = 1}) {
    return personRepository.getPopularPerson(page: page);
  }
}
