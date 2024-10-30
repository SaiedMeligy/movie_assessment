import 'package:movie_assessment/domain/models/PersonProfileModel.dart';

abstract class PersonProfileStates{}
class LoadingPersonProfileStates extends PersonProfileStates{}
class SuccessPersonProfileStates extends PersonProfileStates{
  List<Profiles> profile;
  SuccessPersonProfileStates(this.profile);
}
class ErrorPersonProfileStates extends PersonProfileStates{
  final String errorMessage;
  ErrorPersonProfileStates(this.errorMessage);
}