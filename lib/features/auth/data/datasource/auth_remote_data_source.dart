import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:routines/core/cubits/user_entity/userEntity.dart';
import 'package:routines/core/error/exception.dart';
import 'package:routines/core/secrets/app_secrets.dart';
import 'package:routines/core/utils/check_alldetails.dart';
import 'package:routines/core/utils/get_alldetails.dart';
import 'package:routines/core/utils/store_details.dart';
import 'package:routines/features/auth/data/models/HiveModel/UserEntityModel.dart';
import 'package:routines/features/auth/data/models/elective_model.dart';
import 'package:routines/features/auth/data/models/section_model.dart';
import 'package:routines/features/auth/data/models/teacher_model.dart';

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
    required String year,
    required String coreSection,
    required List<String> electiveSections,
  });
  Future<Map<String, dynamic>> combineTeacherDetails({
    required String year,
    required String branch,
    required String coreSection,
    required List<String> electiveList,
  });
  Future<Userentity?> currentUser();
  Future<Userentity> saveUser({
    required String year,
    required String branch,
    required String coreSection,
    required List<String> electiveList,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<List<int>> branchDetails({
    required String year,
    required String branch,
  }) async {
    try {
      final String _response = await GetAllDetails().getAllDetails();
      final Map<String, dynamic> _data = jsonDecode(_response);

      final SectionNumbersModel sectionNumbersModel =
          SectionNumbersModel.fromJson(_data, year, branch);
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
      final String _response = await GetAllDetails().getAllDetails();
      final Map<String, dynamic> _data = jsonDecode(_response);

      final ElectiveModel electiveModel = ElectiveModel.fromJson(
          json: _data, year: year, branch: branch, elective: elective);
      return electiveModel.electiveSubjects;
    } catch (e) {
      throw const ServerException("Server Error");
    }
  }

  @override
  Future<String> getAllDetails() async {
    try {
      if (!await CheckAllDetailsAvailable().checkAllDetails()) {
        final _response = await Dio().get(AppSecrets.apiURL);
        final responseData = _response.data;
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

  @override
  Future<Map<String, dynamic>> combineTeacherDetails(
      {required String year,
      required String branch,
      required String coreSection,
      required List<String> electiveList}) async {
    try {
      final String _response = await GetAllDetails().getAllDetails();
      Map<String, dynamic> _data = jsonDecode(_response);
      final TeacherModel teacherModel =
          TeacherModel.fromJson(_data, year, branch, coreSection);
      Map<String, dynamic> TeacherData = {};

      if (electiveList.isNotEmpty) {
        for (int i = 0; i < electiveList.length; i++) {
          String subject = "${electiveList[i].split('_')[0]}(DE)";
          final ElectiveModel electiveModel = ElectiveModel.fromJson(
              json: _data,
              year: year,
              branch: branch,
              elective: "elective${i + 1}");
          final electiveSubjects = electiveModel.electiveSubjects;
          final electiveteacher = electiveSubjects[electiveList[i]];

          TeacherData[subject] = electiveteacher;
        }
      }
      TeacherData.addAll(teacherModel.teacherList);

      return TeacherData;
    } catch (e) {
      throw const ServerException("Cannot Fetch Teacher Data");
    }
  }

  @override
  Future<Userentity?> currentUser() async {
    try {
      // final SharedPreferences prefs = await SharedPreferences.getInstance();
      final box = Hive.box<Userentitymodel>('user');

      final user = box.get("user");

      final Userentity? userentity = Userentity(
          year: user?.year,
          branch: user?.branch,
          coreSection: user?.coreSection,
          electiveSections: user?.electiveSections);

      return userentity;
    } catch (e) {
      throw const ServerException("Cannot Get User");
    }
  }

  @override
  Future<Userentity> saveUser(
      {required String year,
      required String branch,
      required String coreSection,
      required List<String> electiveList}) async {
    try {
      final box = Hive.box<Userentitymodel>('user');

      final Userentity user = Userentity(
          year: year,
          branch: branch,
          coreSection: coreSection,
          electiveSections: electiveList);

      final Userentitymodel userentitymodel = Userentitymodel(
          year: year,
          branch: branch,
          coreSection: coreSection,
          electiveSections: electiveList);
      box.put("user", userentitymodel);

      return user;
    } catch (e) {
      throw const ServerException("Cannot Save User");
    }
  }
}
