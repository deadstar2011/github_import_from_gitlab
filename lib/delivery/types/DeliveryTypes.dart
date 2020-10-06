import 'package:optima_delivery_mobile/common/types/AddressTypes.dart';

class DeliveryBuyer {
  String name;
  String phone;

  DeliveryBuyer({
    this.name,
    this.phone,
  });

  factory DeliveryBuyer.fromJson(Map<String, dynamic> json) {
    return DeliveryBuyer(
      phone: json['phone'] as String,
      name: json['name'] as String,
    );
  }
}

class DeliveryClient {
  String name;
  int id;

  DeliveryClient({
    this.name,
    this.id,
  });

  factory DeliveryClient.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    return DeliveryClient(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  void merge(DeliveryClient mergedItem) {
    id = mergedItem.id ?? id;
    name = mergedItem.name ?? name;
  }
}

class DeliveryItem {
  int id;
  String number;
  String saleNumber;
  String deliveryTimePlanned;
  String deliveryTimeFrom;
  String deliveryTimeTo;
  String description;
  bool isDeliveryPaid;
  bool isOrderPaid;
  String paymentMethod;
  double deliveryCost;
  double orderCost;
  String comment;
  int clientId;
  String status;
  DeliveryBuyer buyer;
  Address address;
  DeliveryClient client;

  DeliveryItem({
    this.id,
    this.number,
    this.saleNumber,
    this.deliveryTimePlanned,
    this.deliveryTimeFrom,
    this.deliveryTimeTo,
    this.description,
    this.isDeliveryPaid,
    this.isOrderPaid,
    this.paymentMethod,
    this.deliveryCost,
    this.orderCost,
    this.comment,
    this.clientId,
    this.status,
    this.buyer,
    this.address,
  });

  factory DeliveryItem.fromJson(dynamic json) {
    if (json == null) {
      return null;
    }
    var deliveryCost = json['deliveryCost'];
    var orderCost = json['orderCost'];

    if (deliveryCost is int) {
      deliveryCost = deliveryCost.toDouble();
    }

    if (orderCost is int) {
      orderCost = orderCost.toDouble();
    }

    return DeliveryItem(
      id: json['id'] as int,
      number: json['number'] as String,
      saleNumber: json['saleNumber'] as String,
      deliveryTimePlanned: json['deliveryTimePlanned'] as String,
      deliveryTimeFrom: json['deliveryTimeFrom'] as String,
      deliveryTimeTo: json['deliveryTimeTo'] as String,
      description: json['description'] as String,
      isDeliveryPaid: json['isDeliveryPaid'] as bool,
      isOrderPaid: json['isOrderPaid'] as bool,
      paymentMethod: json['paymentMethod'] as String,
      deliveryCost: deliveryCost as double,
      orderCost: orderCost as double,
      comment: json['comment'] as String,
      clientId: json['clientId'] as int,
      status: json['status'] as String,
      buyer: DeliveryBuyer.fromJson(json['buyer'] as Map<String, dynamic>),
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
    );
  }

  void merge(DeliveryItem mergedItem) {
    number = mergedItem.number ?? number;
    saleNumber = mergedItem.saleNumber ?? saleNumber;
    deliveryTimePlanned = mergedItem.deliveryTimePlanned ?? deliveryTimePlanned;
    deliveryTimeFrom = mergedItem.deliveryTimeFrom ?? deliveryTimeFrom;
    deliveryTimeTo = mergedItem.deliveryTimeTo ?? deliveryTimeTo;
    description = mergedItem.description ?? description;
    isDeliveryPaid = mergedItem.isDeliveryPaid ?? isDeliveryPaid;
    isOrderPaid = mergedItem.isOrderPaid ?? isOrderPaid;
    paymentMethod = mergedItem.paymentMethod ?? paymentMethod;
    deliveryCost = mergedItem.deliveryCost ?? deliveryCost;
    orderCost = mergedItem.orderCost ?? orderCost;
    comment = mergedItem.comment ?? comment;
    clientId = mergedItem.clientId ?? clientId;
    status = mergedItem.status ?? status;
    buyer = mergedItem.buyer ?? buyer;
    address = mergedItem.address ?? address;
  }
}
