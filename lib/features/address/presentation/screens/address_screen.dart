import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_clean_architecture/config/routes/routes.dart';
import 'package:shop_clean_architecture/core/extentions/context_extension.dart';
import 'package:shop_clean_architecture/core/widgets/custom_button.dart';
import '../../../../core/widgets/error_screen.dart';
import '../cubit/address_cubit.dart';
import '../widgets/address_item.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addressCubit = BlocProvider.of<AddressCubit>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Address')),
      body: BlocBuilder<AddressCubit, AddressState>(
        builder: (context, state) {
          if (state is GetAddressLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetAddressError) {
            return ErrorScreen(
              onTap: () => addressCubit.getAddress(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount:
                          addressCubit.addressModel?.data?.data?.length ?? 0,
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                      itemBuilder: (BuildContext context, int index) =>
                          AddressItem(
                              addressData: addressCubit
                                  .addressModel?.data?.data?[index]),
                    ),
                  ),
                  CustomButton(
                      title: 'Add New Address',
                      onTap: () => context.goTo(Routes.addNewAddressScreen)),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
