import 'package:dio/dio.dart';
abstract class PopularPersonDataSource{
Future<Response> getAllPopularPerson ({int page});
}