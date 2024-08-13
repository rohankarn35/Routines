import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:routines/core/error/exception.dart';
import 'package:routines/core/secrets/app_secrets.dart';
import 'package:routines/core/utils/check_alldetails.dart';
import 'package:routines/core/utils/get_alldetails.dart';
import 'package:routines/core/utils/store_details.dart';
import 'package:routines/features/auth/data/models/elective_model.dart';
import 'package:routines/features/auth/data/models/section_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<List<int>> branchDetails({
    required String year,
    required String branch,
  });
  Future<Map<String, dynamic>> getElectiveSubjectDetails({
    required String year,
    required String branch,
    required String elective,
  });
  Future<String> getAllDetails();
  Future<Map<String, dynamic>> configRoutines({
    required final String year,
    required String coreSection,
    required List<String> electiveSections,
  });
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
      final SectionNumbersModel sectionNumbersModel =
          SectionNumbersModel.fromJson(data, year, branch);
      final int core = sectionNumbersModel.core;
      final int elective = sectionNumbersModel.elective;
      return [core, elective];
    } catch (e) {
      throw const ServerException("Server Error");
    }
  }

  @override
  Future<Map<String, dynamic>> getElectiveSubjectDetails({
    required String year,
    required String branch,
    required String elective,
  }) async {
    try {
      final String response = await GetAllDetails().getAllDetails();
      final Map<String, dynamic> data = jsonDecode(response);

      final ElectiveModel electiveModel = ElectiveModel.fromJson(
          json: data, year: year, branch: branch, elective: elective);
      return electiveModel.electiveSubjects;
    } catch (e) {
      print(e);
      throw ServerException("Server Error");
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

  @override
  Future<Map<String, dynamic>> configRoutines({
    required final String year,
    required String coreSection,
    required List<String> electiveSections,
  }) async {
    try {
      String electiveSection = "";
      if (electiveSections.isNotEmpty) {
        electiveSection = electiveSections.join(",");
      }
      final apiUrl = year == "second"
          ? "${AppSecrets.secondYearUrl}${coreSection}&electiveSections=${electiveSection}"
          : "${AppSecrets.thirdYearUrl}${coreSection}&electiveSections=${electiveSection}";

      final res = await Dio().get(apiUrl);
      final Map<String, dynamic> data = res.data;
      return data;
    } catch (e) {
      throw const ServerException("Cannot Connect to the server");
    }
  }
}
