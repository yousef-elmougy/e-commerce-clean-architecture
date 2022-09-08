import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utiles/validators.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_space.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../cubit/address_cubit.dart';

class AddAndUpdateForm extends StatelessWidget {
  const AddAndUpdateForm({Key? key, this.onTap, this.text}) : super(key: key);

  final GestureTapCallback? onTap;
  final String? text;

  @override
  Widget build(BuildContext context) {
    final addressCubit = BlocProvider.of<AddressCubit>(context);

    return Form(
      autovalidateMode: AutovalidateMode.always,
      key: addressCubit.addressFormKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VerticalSpace(3),
              CustomTextFormField(
                controller: addressCubit.addressNameController,
                validator: (String? value) {
                  if (value!.isEmpty) return "can't be Empty";
                },
                labelText: 'NAME',
              ),
              const VerticalSpace(3),
              CustomTextFormField(
                controller: addressCubit.addressCityController,
                validator: (String? value) {
                  if (value!.isEmpty) return "can't be Empty";
                },
                labelText: 'CITY',
              ),
              const VerticalSpace(3),
              CustomTextFormField(
                controller: addressCubit.addressRegionController,
                labelText: 'REGION',
                validator: (String? value) {
                  if (value!.isEmpty) return "can't be Empty";
                  },
              ),
              const VerticalSpace(3),
              CustomTextFormField(
                controller: addressCubit.addressDetailsController,
                labelText: 'DETAILS',
                validator: (String? value) {
                  if (value!.isEmpty) return "can't be Empty";
                  },
              ),
              const VerticalSpace(3),
              CustomTextFormField(
                controller: addressCubit.addressNotesController,
                labelText: 'NOTES',
                validator: (String? value) {
                  if (value!.isEmpty) return "can't be Empty";
                  },
              ),
              const VerticalSpace(5),
              CustomButton(
                title: '$text',
                onTap: onTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
