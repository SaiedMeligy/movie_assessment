import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:movie_assessment/data/DataSource/PersonProfile/person_pofile_data_source.dart';
import 'package:movie_assessment/data/DataSource/PersonProfile/person_profile_data_source_imp.dart';
import 'package:movie_assessment/data/Repository_Imp/person_profile_rep_imp.dart';
import 'package:movie_assessment/domain/models/PersonProfileModel.dart';
import 'package:movie_assessment/domain/useCase/PersonProfile/person_profile_use_case.dart';
import 'package:movie_assessment/features/PersonProfile/manager/states.dart';

import '../../../domain/Repository/PersonProfileRepository/person_profile_repository.dart';

class PersonProfileCubit extends Cubit<PersonProfileStates>{
  PersonProfileCubit() : super(LoadingPersonProfileStates());
  late PersonProfileUseCase personProfileUseCase;
  late PersonProfileRepository personProfileRepository;
  late PersonProfileDataSource personProfileDataSource;



  void fetchPersonProfile(int personId) async {

    Dio dio = Dio();
    personProfileDataSource = PersonProfileDataSourceImp(dio);
    personProfileRepository = PersonProfileRepositoryImp(personProfileDataSource);
    personProfileUseCase = PersonProfileUseCase(personProfileRepository);

    try {
      final response = await personProfileUseCase.execute(personId);
      final data = PersonProfileModel.fromJson(response.data);
      emit(SuccessPersonProfileStates(data.profiles ?? []));

    } catch (e) {
      emit(ErrorPersonProfileStates(e.toString()));
    }
  }
}