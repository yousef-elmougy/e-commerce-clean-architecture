import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_clean_architecture/config/routes/routes.dart';
import 'package:shop_clean_architecture/core/extentions/context_extension.dart';
import 'package:shop_clean_architecture/core/utiles/validators.dart';
import 'package:shop_clean_architecture/core/widgets/custom_space.dart';
import '../../../../core/utiles/constants.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../cubit/user/user_cubit.dart';
import '../cubit/user/user_state.dart';
import '../cubit/visibility/visibility_cubit.dart';
import '../widgets/register_login_text_bottom.dart';
import 'package:shop_clean_architecture/injection_container.dart' as di;

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userCubit = BlocProvider.of<UserCubit>(context);
    final visibilityCubit = BlocProvider.of<VisibilityCubit>(context);
    return WillPopScope(
      onWillPop: () => AppConstants.showExitPopup(context),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: userCubit.loginFormKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSpace(20),
                  const Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 40),
                  ),
                  const VerticalSpace(7),
                  CustomTextFormField(
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email,
                    controller: userCubit.loginEmailController,
                    validator: (String? value) =>
                        validInput(value!, 10, 30, 'email'),
                    labelText: 'EMAIL',
                  ),
                  const VerticalSpace(4),
                  BlocBuilder<VisibilityCubit, VisibilityState>(
                    builder: (BuildContext context, state) {
                      return CustomTextFormField(
                        controller: userCubit.loginPasswordController,
                        keyboardType: TextInputType.text,
                        prefixIcon: Icons.lock,
                        suffixIcon: visibilityCubit.isVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        onPressedSuffixIcon: visibilityCubit.changeVisibility,
                        obscureText: visibilityCubit.isVisible ? false : true,
                        validator: (String? value) =>
                            validInput(value!, 6, 30, 'password'),
                        labelText: 'PASSWORD',
                      );
                    },
                  ),
                  const VerticalSpace(7),
                  BlocConsumer<UserCubit, UserState>(
                    listener: (BuildContext context, state) {
                      if (state is UserLoaded) {
                        state.userModel.status == true
                            ? context.goToReplace(Routes.layoutScreen)
                            : AppConstants.showToast(
                                msg: state.userModel.message.toString());
                      }
                    },
                    builder: (BuildContext context, Object? state) {
                      if (state is UserLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return CustomButton(
                          title: 'LOGIN',
                          onTap: () => userCubit.loginFormKey.currentState!.validate()
                                  ? userCubit.login()
                                  : null,
                          // if (userCubit.loginFormKey.currentState!
                          //     .validate()) {
                          //   userCubit.login();
                          // }
                        );
                      }
                    },
                  ),
                  const VerticalSpace(2),
                  const CustomTextBottom(
                      text: 'Do have an account?  ',
                      textBottom: 'REGISTER',
                      routeName: Routes.registerScreen),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
