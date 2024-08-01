import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:routines/core/error/exception.dart';
import 'package:routines/core/secrets/app_secrets.dart';
import 'package:routines/core/utils/check_alldetails.dart';
import 'package:routines/core/utils/get_alldetails.dart';
import 'package:routines/core/utils/store_details.dart';

abstract interface class AuthRemoteDataSource {
  Future<List<int>> branchDetails({
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
  Future<List<int>> branchDetails({
    required String year,
    required String branch,
  }) async {
    try {
      final String response = await GetAllDetails().getAllDetails();
      final Map<String, dynamic> data = jsonDecode(response);

      return [2, 2];
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
      final Map<String, dynamic> data = {};
      return data['elective'].toString();
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<String> getAllDetails() async {
    try {
      if (!await CheckAllDetailsAvailable().checkAllDetails()) {
        final response = await Dio().get(AppSecrets.apiURL);
        final responseData = response.data;
        final Map<String, dynamic> data = jsonDecode(responseData);
        final String jsonString = jsonEncode(data);
        StoreDetails().storeDetails(data: jsonString);
        return jsonString;
      } else {
        return GetAllDetails().getAllDetails();
      }
    } catch (e) {
      throw const ServerException("An Error Occured");
    }
  }
}
