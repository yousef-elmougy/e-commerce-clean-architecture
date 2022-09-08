import 'package:shop_clean_architecture/core/api/dio_consumer.dart';
import 'package:shop_clean_architecture/core/api/end_points.dart';
import 'package:shop_clean_architecture/features/address/data/models/add_update_delete_address.dart';
import '../models/address_model.dart';

abstract class AddressRemoteDataSource {
  Future<AddressModel> getAddress();

  Future<AddUpdateDeleteAddressModel> addAddress({
    double? latitude,
    double? longitude,
    String? name,
    String? city,
    String? region,
    String? details,
    String? notes,
  });

  Future<AddUpdateDeleteAddressModel> updateAddress({
    int? addressID,
    double? latitude,
    double? longitude,
    String? name,
    String? city,
    String? region,
    String? details,
    String? notes,
  });

  Future<AddUpdateDeleteAddressModel> deleteAddress({int? addressID});
}

class AddressRemoteDataSourceImpl implements AddressRemoteDataSource {
  final DioConsumer dioConsumer;

  AddressRemoteDataSourceImpl({required this.dioConsumer});

  @override
  Future<AddressModel> getAddress() async => await dioConsumer
      .get(ApiEndPoints.addresses)
      .then((value) => AddressModel.fromJson(value));

  @override
  Future<AddUpdateDeleteAddressModel> addAddress(
          {double? latitude,
          double? longitude,
          String? name,
          String? city,
          String? region,
          String? details,
          String? notes}) async =>
      await dioConsumer.post(
        ApiEndPoints.addresses,
        queryParameters: {
          'name': name,
          'city': city,
          'region': region,
          'details': details,
          'latitude': latitude,
          'longitude': longitude,
          'notes': notes,
        },
      ).then((value) => AddUpdateDeleteAddressModel.fromJson(value));

  @override
  Future<AddUpdateDeleteAddressModel> updateAddress(
          {int? addressID,
          double? latitude,
          double? longitude,
          String? name,
          String? city,
          String? region,
          String? details,
          String? notes}) async =>
      await dioConsumer.put(
        '${ApiEndPoints.addresses}/$addressID',
        queryParameters: {
          'name': name,
          'city': city,
          'region': region,
          'details': details,
          'latitude': latitude,
          'longitude': longitude,
          'notes': notes,
        },
      ).then((value) => AddUpdateDeleteAddressModel.fromJson(value));

  @override
  Future<AddUpdateDeleteAddressModel> deleteAddress({int? addressID}) async =>
      await dioConsumer
          .delete('${ApiEndPoints.addresses}/$addressID')
          .then((value) => AddUpdateDeleteAddressModel.fromJson(value));
}
