import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utiles/validators.dart';
import '../../../../core/widgets/custom_space.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../user/presentation/cubit/user/user_cubit.dart';
import '../../user/presentation/cubit/user/user_state.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userCubit = BlocProvider.of<UserCubit>(context);
    return Scaffold(
      appBar: AppBar(
          title: const Text('Change Password'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          return Form(
            autovalidateMode: AutovalidateMode.always,
            key: userCubit.changePasswordFormKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSpace(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Security Information',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      if (state is ChangePasswordLoading)
                        const Center(child: CircularProgressIndicator())
                      else
                        InkWell(
                          onTap: () {
                            userCubit.changePasswordFormKey.currentState!
                                    .validate()
                                ? userCubit.changePassword(context)
                                : null;
                          },
                          child: Row(
                            children: const [
                              Icon(Icons.edit, color: Colors.blue, size: 20),
                              Text(' Edit',
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 20)),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const VerticalSpace(3),
                  CustomTextFormField(
                    controller: userCubit.currentPasswordController,
                    keyboardType: TextInputType.text,
                    prefixIcon: Icons.lock,
                    validator: (String? value) =>
                        validInput(value!, 6, 30, 'password'),
                    labelText: 'CURRENT PASSWORD',
                  ),
                  const VerticalSpace(3),
                  CustomTextFormField(
                    controller: userCubit.newPasswordController,
                    keyboardType: TextInputType.text,
                    prefixIcon: Icons.lock,
                    validator: (String? value) =>
                        validInput(value!, 6, 30, 'password'),
                    labelText: 'NEW PASSWORD',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
