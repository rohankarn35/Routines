import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routines/core/utils/toastbar.dart';
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
              CustomDialog().showCustomDialog(context);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              dialogBoxButtonText = "Downloading Some Resources...";
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
              children: [
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
                    onPressed: () {
                      HapticFeedback.heavyImpact();
                      context.read<AuthBloc>().add(AuthSetupButtonClicked());
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
