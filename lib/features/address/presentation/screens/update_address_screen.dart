import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_clean_architecture/core/extentions/context_extension.dart';
import 'package:shop_clean_architecture/features/address/data/models/address_model.dart';
import '../cubit/address_cubit.dart';
import '../widgets/add_and_update_form_address.dart';

class UpdateAddressScreen extends StatelessWidget {
  const UpdateAddressScreen({Key? key, required this.addressData})
      : super(key: key);

  final AddressData addressData;

  @override
  Widget build(BuildContext context) {
    final addressCubit = BlocProvider.of<AddressCubit>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Update Address')),
      body: BlocBuilder<AddressCubit, AddressState>(
        builder: (context, state) {
          addressCubit.addressCityController.text =
              '${addressData.city?.trim()}';
          addressCubit.addressNameController.text =
              '${addressData.name?.trim()}';
          addressCubit.addressRegionController.text =
              '${addressData.region?.trim()}';
          addressCubit.addressNotesController.text =
              '${addressData.notes?.trim()}';
          addressCubit.addressDetailsController.text =
              '${addressData.details?.trim()}';
          return AddAndUpdateForm(
              text: 'Update Address',
              onTap: () => addressCubit
                  .updateAddress(addressID: addressData.id)
                  .then((value) => context.back()));
        },
      ),
    );
  }
}
