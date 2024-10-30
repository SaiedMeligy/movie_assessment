import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:movie_assessment/data/DataSource/PopularPerson/popular_person_data_source.dart';
import 'package:movie_assessment/data/DataSource/PopularPerson/popular_person_data_source_imp.dart';
import 'package:movie_assessment/data/Repository_Imp/popular_person_rep_imp.dart';
import 'package:movie_assessment/domain/Repository/PopularPersonRepository/popular_person_repository.dart';
import 'package:movie_assessment/domain/useCase/PopularPerson/popular_person_use_case.dart';
import 'package:movie_assessment/features/PopularPerson/manager/states.dart';
import 'package:movie_assessment/domain/models/PopularPersonModel.dart';

class PopularPersonCubit extends Cubit<PopularPersonStates> {
  int currentPage = 1;
  bool isLastPage = false;
  bool isLoading = false;
  List<Results> persons = [];

  PopularPersonCubit() : super(LoadingPopularPersonStates());

  late PopularPersonUseCase personUseCase;
  late PopularPersonRepository personRepository;
  late PopularPersonDataSource personDataSource;

  void fetchPopularPerson({bool loadMore = false}) async {
    if (isLoading || isLastPage) return;

    if (!loadMore) {
      emit(LoadingPopularPersonStates());
    }
    isLoading = true;

    Dio dio = Dio();
    personDataSource = PopularPersonDataSourceImp(dio);
    personRepository = PopularPersonRepositoryImp(personDataSource);
    personUseCase = PopularPersonUseCase(personRepository);

    try {
      final response = await personUseCase.execute(page: currentPage);
      final data = PopularPersonModel.fromJson(response.data);

      if (data.results!.isEmpty) {
        isLastPage = true;
      } else {
        persons.addAll(data.results ?? []);
        currentPage++;
      }

      emit(SuccessPopularPersonState(persons));
    } catch (error) {
      emit(ErrorPopularPersonState(error.toString()));
    } finally {
      isLoading = false;
    }
  }
}