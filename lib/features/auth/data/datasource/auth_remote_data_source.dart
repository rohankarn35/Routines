import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:routines/core/error/exception.dart';
import 'package:routines/core/secrets/app_secrets.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> branchDetails({
    required String year,
    required String branch,
  });
  Future<String> getElectiveSubjectDetails({
    required String year,
    required String branch,
  });
  Future<String> getAllDetails();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<String> branchDetails({
    required String year,
    required String branch,
  }) async {
    try {
      final response = await Dio().get(AppSecrets.apiURL);
      final responseData = response.data;
      final Map<String, dynamic> data = jsonDecode(responseData);
      if (!data.containsKey(year) ||
          !data[year].containsKey('core') ||
          !data[year].containsKey('elective')) {
        throw const ServerException("Invalid Data");
      }

      final int coreCount = data[year]['core'][branch];
      final int electiveCount = data[year]['elective'][branch];

      final branchjsonData = {
        "core": coreCount,
        "elective": electiveCount,
      };
      final String jsonString = jsonEncode(branchjsonData);
      return jsonString;
    } catch (e) {
      throw const ServerException("Server Error");
    }
  }

  @override
  Future<String> getElectiveSubjectDetails({
    required String year,
    required String branch,
  }) async {
    try {
      final branchdetails = await branchDetails(year: year, branch: branch);
      final Map<String, dynamic> data = jsonDecode(branchdetails);
      return data['elective'].toString();
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<String> getAllDetails() async {
    try {
      final response = await Dio().get(AppSecrets.apiURL);
      final responseData = response.data;
      final Map<String, dynamic> data = jsonDecode(responseData);
      final String jsonString = jsonEncode(data);
      return jsonString;
    } catch (e) {
      throw ServerException("An Error Occured");
    }
  }
}
