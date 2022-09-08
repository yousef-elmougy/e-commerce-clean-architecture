import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_clean_architecture/core/utiles/constants.dart';
import 'package:shop_clean_architecture/features/user/presentation/cubit/user/user_cubit.dart';
import 'package:shop_clean_architecture/features/user/presentation/widgets/register_login_text_bottom.dart';
import '../../../../config/routes/routes.dart';
import '../../../../core/utiles/validators.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../cubit/user/user_state.dart';
import '../cubit/visibility/visibility_cubit.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userCubit = BlocProvider.of<UserCubit>(context);
    return WillPopScope(
      onWillPop: () => AppConstants.showExitPopup(context),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: userCubit.registerFormKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  const Text('REGISTER', style: TextStyle(fontSize: 40)),
                  const SizedBox(height: 30),
                  CustomTextFormField(
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.person,
                    controller: userCubit.registerNameController,
                    validator: (String? value) =>
                        validInput(value!, 3, 20, 'username'),
                    labelText: 'NAME',
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email,
                    controller: userCubit.registerEmailController,
                    validator: (String? value) =>
                        validInput(value!, 10, 30, 'email'),
                    labelText: 'EMAIL',
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    keyboardType: TextInputType.number,
                    prefixIcon: Icons.phone,
                    controller: userCubit.registerPhoneController,
                    validator: (String? value) =>
                        validInput(value!, 7, 11, 'phone'),
                    labelText: 'PHONE',
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<VisibilityCubit, VisibilityState>(
                    builder: (BuildContext context, state) {
                      return CustomTextFormField(
                        controller: userCubit.registerPasswordController,
                        keyboardType: TextInputType.text,
                        prefixIcon: Icons.lock,
                        suffixIcon:
                            BlocProvider.of<VisibilityCubit>(context).isVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                        onPressedSuffixIcon:
                            BlocProvider.of<VisibilityCubit>(context)
                                .changeVisibility,
                        obscureText:
                            BlocProvider.of<VisibilityCubit>(context).isVisible
                                ? false
                                : true,
                        validator: (String? value) =>
                            validInput(value!, 6, 30, 'password'),
                        labelText: 'PASSWORD',
                      );
                    },
                  ),
                  const SizedBox(height: 50),
                  BlocConsumer<UserCubit, UserState>(
                    listener: (BuildContext context, state) {
                      if (state is UserLoaded) {
                        state.userModel.status == true
                            ? Navigator.pushReplacementNamed(
                                context, Routes.layoutScreen)
                            : AppConstants.showToast(
                                msg: state.userModel.message.toString());
                      }
                    },
                    builder: (BuildContext context, Object? state) {
                      if (state is UserLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return CustomButton(
                          title: 'REGISTER',
                          onTap: () {
                            if (userCubit.registerFormKey.currentState!
                                .validate()) {
                              userCubit.register();
                            }
                          },
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  const CustomTextBottom(
                      text: 'Don\'t have an account?  ',
                      textBottom: 'LOGIN',
                      routeName: Routes.loginScreen),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
