import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_clean_architecture/core/extentions/context_extension.dart';
import '../../../../config/routes/routes.dart';
import '../../../../core/widgets/custom_space.dart';
import '../../../../core/widgets/error_screen.dart';
import '../../../../core/widgets/icon_text_button.dart';
import '../../data/models/address_model.dart';
import '../cubit/address_cubit.dart';

class AddressItem extends StatelessWidget {
  const AddressItem({Key? key, this.addressData}) : super(key: key);

  final AddressData? addressData;

  @override
  Widget build(BuildContext context) {
    final addressCubit = BlocProvider.of<AddressCubit>(context);
    return BlocBuilder<AddressCubit, AddressState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 25),
                    Text('  ${addressData?.name}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
                Row(
                  children: [
                    state is AddUpdateDeleteAddressLoading
                        ? const Center(child: CircularProgressIndicator())
                        : state is AddUpdateDeleteAddressError
                            ? ErrorScreen(
                                onTap: () => addressCubit.getAddress(),
                              )
                            : IconTextButton(
                                onTap: () => addressCubit.deleteAddress(
                                    addressID: addressData?.id),
                                color: Colors.red,
                                icon: Icons.delete,
                                size: 20,
                                text: ' Delete',
                              ),
                    const HorizontalSpace(3),
                    IconTextButton(
                      onTap: () => context.goTo(Routes.updateAddressScreen,
                          args: addressData),
                      color: Colors.blue,
                      icon: Icons.edit,
                      size: 20,
                      text: ' Edit',
                    ),
                  ],
                ),
              ],
            ),
            const VerticalSpace(3),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    AddressText(text: 'City'),
                    AddressText(text: 'Region'),
                    AddressText(text: 'Details'),
                    AddressText(text: 'Notes'),
                  ],
                ),
                const HorizontalSpace(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AddressText(text: '${addressData?.city}'),
                    AddressText(text: '${addressData?.region}'),
                    AddressText(text: '${addressData?.details}'),
                    AddressText(text: '${addressData?.notes}'),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
class AddressText extends StatelessWidget {
  const AddressText({Key? key, this.text}) : super(key: key);

  final String? text;

  @override
  Widget build(BuildContext context) =>
      Text('$text', style: const TextStyle(fontSize: 20));
}
