import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routines/core/utils/get_alldetails.dart';
import 'package:routines/core/utils/toastbar.dart';
import 'package:routines/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:routines/features/auth/data/models/elective_model.dart';
import 'package:routines/features/auth/data/repository/auth_repository_impl.dart';
import 'package:routines/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:routines/features/auth/presentation/widgets/custom_dialogbox_widget.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SelectionPage extends StatefulWidget {
  const SelectionPage({super.key});

  @override
  State<SelectionPage> createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  String dialogBoxButtonText = "Setup Your Routines";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSucess) {
              CustomDialog().customDialog(context);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              dialogBoxButtonText = "Downloading Some Resources...";
              print("loading");
            }
            if (state is AuthFailure) {
              dialogBoxButtonText = "Setup Your Routines";
              showToast(state.failureText, Colors.red);
            }
            if (state is AuthSucess) {
              dialogBoxButtonText = "Setup Your Routines";
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                GradientText(
                  "ROUTINES",
                  style: const TextStyle(
                      fontSize: 50, fontWeight: FontWeight.bold),
                  gradientType: GradientType.linear,
                  colors: const [
                    Colors.green,
                    Colors.greenAccent,
                    Colors.white,
                    Colors.white
                  ],
                ),
                Spacer(),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 60,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      textStyle: const TextStyle(color: Colors.white),
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () async {
                      // await CheckAllDetailsAvailable().checkAllDetails();

                      // CustomDialog().customDialog(context);
                      // context.read<AuthBloc>().add(
                      //     AuthBranchAndYearSelectedEvent(
                      //         branch: "CSE", year: "second"));
                      // context.read<AuthBloc>().add(AuthSetupButtonClicked());
                      final String response =
                          await GetAllDetails().getAllDetails();
                      final Map<String, dynamic> data = jsonDecode(response);
                      final ElectiveModel electiveModel =
                          ElectiveModel.fromJson(
                              json: data,
                              year: "third",
                              branch: "CSE",
                              elective: "elective1");
                      print(electiveModel.electiveSubjects);
                    },
                    child: Text(
                      dialogBoxButtonText,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            );
          },
        ),
      ),
    );
  }
}
