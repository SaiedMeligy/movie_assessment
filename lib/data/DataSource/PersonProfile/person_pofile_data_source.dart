
import 'package:dio/dio.dart';

abstract class PersonProfileDataSource{
  Future<Response> getPersonProfile(int personId);
}