import 'package:dio/dio.dart';

abstract class PersonProfileRepository{
  Future<Response> getPersonProfile(int personId);
}