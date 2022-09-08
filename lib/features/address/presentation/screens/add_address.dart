import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_clean_architecture/core/extentions/context_extension.dart';
import '../cubit/address_cubit.dart';
import '../widgets/add_and_update_form_address.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addressCubit = BlocProvider.of<AddressCubit>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Add Address')),
      body: BlocBuilder<AddressCubit, AddressState>(
        builder: (context, state) {
          return AddAndUpdateForm(
            text: 'Add New Address',
            onTap: () {
              if(addressCubit.addressFormKey.currentState!.validate()) {
                addressCubit.addAddress().then((value) {
              context.back();
              addressCubit.addressCityController.clear();
              addressCubit.addressNameController.clear();
              addressCubit.addressRegionController.clear();
              addressCubit.addressNotesController.clear();
              addressCubit.addressDetailsController.clear();
            });
              }
            },
          );
        },
      ),
    );
  }
}
