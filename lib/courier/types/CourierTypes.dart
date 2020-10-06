import 'package:optima_delivery_mobile/common/types/AddressTypes.dart';

class CourierVehicle {
  String name;
  String number;
  int id;

  CourierVehicle({
    this.name,
    this.id,
    this.number,
  });

  factory CourierVehicle.fromJson(Map<String, dynamic> json) {
    return CourierVehicle(
      id: json['id'] as int,
      name: json['name'] as String,
      number: json['number'] as String,
    );
  }
}

class CourierWarehouse {
  Address address;
  String dispatcherPhone;
  String name;
  int id;

  CourierWarehouse({
    this.name,
    this.id,
    this.dispatcherPhone,
    this.address,
  });

  factory CourierWarehouse.fromJson(Map<String, dynamic> json) {
    return CourierWarehouse(
      id: json['id'] as int,
      name: json['name'] as String,
      dispatcherPhone: json['dispatcherPhone'] as String,
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
    );
  }
}

class Courier {
  int id;
  String firstName;
  String middleName;
  String lastName;
  int warehouseId;
  bool isOnShift;
  bool isInWarehouse;
  CourierVehicle vehicle;
  CourierWarehouse warehouse;

  Courier({
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.warehouseId,
    this.isOnShift,
    this.isInWarehouse,
    this.vehicle,
    this.warehouse,
  });

  factory Courier.fromJson(Map<String, dynamic> json) {
    return Courier(
      id: json['id'] as int,
      firstName: json['firstName'] as String,
      middleName: json['middleName'] as String,
      lastName: json['lastName'] as String,
      warehouseId: json['warehouseId'] as int,
      isOnShift: json['isOnShift'] as bool,
      isInWarehouse: json['isInWarehouse'] as bool,
      vehicle: null,
      warehouse: null,
    );
  }

  void merge(Courier mergedItem) {
    id = mergedItem.id ?? id;
    firstName = mergedItem.firstName ?? firstName;
    middleName = mergedItem.middleName ?? middleName;
    lastName = mergedItem.lastName ?? lastName;
    warehouseId = mergedItem.warehouseId ?? warehouseId;
    isOnShift = mergedItem.isOnShift ?? isOnShift;
    isInWarehouse = mergedItem.isInWarehouse ?? isInWarehouse;
    vehicle = mergedItem.vehicle ?? vehicle;
    warehouse = mergedItem.warehouse ?? warehouse;
  }
}
