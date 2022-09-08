import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_clean_architecture/config/routes/routes.dart';
import 'package:shop_clean_architecture/core/extentions/context_extension.dart';
import 'package:shop_clean_architecture/core/utiles/constants.dart';
import 'package:shop_clean_architecture/core/widgets/custom_space.dart';
import 'package:shop_clean_architecture/core/widgets/custom_text_form_field.dart';
import 'package:shop_clean_architecture/features/user/presentation/cubit/user/user_cubit.dart';
import 'package:shop_clean_architecture/features/user/presentation/cubit/user/user_state.dart';

import '../../../../core/utiles/validators.dart';
import '../../../../core/widgets/icon_text_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userCubit = BlocProvider.of<UserCubit>(context);
    userCubit.getProfile();
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserLoaded &&
              state.userModel.status == false &&
              state.userModel.message != null) {
            AppConstants.showToast(msg: '${state.userModel.message}');
          }
        },
        builder: (context, state) {
          final user = userCubit.userModel?.data;
          userCubit.updateNameController.text =
              '${user?.name.toString().trim()}';
          userCubit.updateEmailController.text =
              '${user?.email.toString().trim()}';
          userCubit.updatePhoneController.text =
              '${user?.phone.toString().trim()}';
          return Form(
            autovalidateMode: AutovalidateMode.always,
            key: userCubit.updateProfileFormKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Personal Information',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        if (state is UserLoading)
                          const Center(child: CircularProgressIndicator())
                        else
                          IconTextButton(
                            onTap: () => userCubit
                                    .updateProfileFormKey.currentState!
                                    .validate()
                                ? userCubit.updateProfile()
                                : null,
                            color: Colors.blue,
                            icon: Icons.edit,
                            size: 20,
                            text: ' Edit',
                          ),
                      ],
                    ),
                    const VerticalSpace(3),
                    CustomTextFormField(
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icons.person,
                      controller: userCubit.updateNameController,
                      validator: (String? value) =>
                          validInput(value!, 3, 20, 'username'),
                      labelText: 'NAME',
                    ),
                    const VerticalSpace(3),
                    CustomTextFormField(
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icons.email,
                      controller: userCubit.updateEmailController,
                      validator: (String? value) =>
                          validInput(value!, 3, 50, 'email'),
                      labelText: 'EMAIL',
                    ),
                    const VerticalSpace(3),
                    CustomTextFormField(
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.phone,
                      controller: userCubit.updatePhoneController,
                      validator: (String? value) =>
                          validInput(value!, 6, 11, 'phone'),
                      labelText: 'PHONE',
                    ),
                    const VerticalSpace(5),
                    const Text(
                      'security Information',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const VerticalSpace(2),
                    ElevatedButton(
                      onPressed: () =>
                          context.goTo(Routes.changePasswordScreen),
                      child: const Text(
                        'Change Password',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
