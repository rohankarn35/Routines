import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:routines/core/error/exception.dart';
import 'package:routines/core/secrets/app_secrets.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> branchDetails({
    required String year,
    required String branch,
  });
  Future<List<String>> getElectiveSubjectDetails({
    required String year,
    required String branch,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<String> branchDetails({
    required String year,
    required String branch,
  }) async {
    try {
      final response = await Dio().get(AppSecrets.branchdetailsApi);
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
  Future<List<String>> getElectiveSubjectDetails({
    required String year,
    required String branch,
  }) async {
    
    try {
        final branchdetails = await branchDetails(year: year, branch: branch);
        final Map<String, dynamic> data = jsonDecode(branchdetails);
        print(data['elective']);
        return ["jgbdjh","dfsdjhfhsjdf"];
      
    } catch (e) {
      print(e);
      throw UnimplementedError();
    }
  }
}
