import 'package:movie_assessment/domain/models/PopularPersonModel.dart';

abstract class PopularPersonStates{}
class LoadingPopularPersonStates extends PopularPersonStates{}
class SuccessPopularPersonState extends PopularPersonStates{
  List<Results> results;
  SuccessPopularPersonState(this.results);
}
class ErrorPopularPersonState extends PopularPersonStates{

  final String errorMessage;
ErrorPopularPersonState(this.errorMessage);
}