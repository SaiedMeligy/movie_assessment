import 'package:dio/dio.dart';

abstract class PopularPersonRepository{
  Future<Response> getPopularPerson({int page});
}