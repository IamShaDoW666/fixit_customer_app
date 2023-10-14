import 'package:booking_system_flutter/model/package_data_model.dart';
import 'package:booking_system_flutter/model/slot_data.dart';
import 'package:booking_system_flutter/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/model_keys.dart';

class ServiceData {
  int? id;
  int? categoryId;
  int? providerId;
  int? cityId;
  int? status;
  int? isFeatured;
  int? bookingAddressId;
  num? price;
  num? pricePerSqft;
  num? discount;
  num? totalReview;
  num? totalRating;
  num? isFavourite;
  num? isSlot;
  num? serviceId;
  num? userId;
  String? duration;
  String? description;
  String? providerName;
  String? categoryName;
  String? subCategoryName;
  String? providerImage;
  String? name;
  String? type;
  String? createdAt;
  String? customerName;
  String? bookingDate;
  String? bookingDay;
  String? bookingSlot;
  String? dateTimeVal;
  String? bookingDescription;
  String? address;
  num? isEnableAdvancePayment;
  num? advancePaymentPercentage;
  num? advancePaymentAmount;
  bool? customizable;
  List<String>? attachments;
  List<String>? serviceAttachments;
  List<ServiceAddressMapping>? serviceAddressMapping;
  List<SlotData>? bookingSlots;
  List<BookingPackage>? servicePackage;
  List<Option>? options;

  //Local
  bool get isSlotAvailable => isSlot.validate() == 1;

  bool get isHourlyService => type.validate() == SERVICE_TYPE_HOURLY;

  bool get isFixedService => type.validate() == SERVICE_TYPE_FIXED;

  bool get isFreeService => price.validate() == 0;

  bool get isAdvancePayment =>
      isEnableAdvancePayment.validate() == 1 &&
      getBoolAsync(IS_ADVANCE_PAYMENT_ALLOWED) &&
      servicePackage.validate().isEmpty;

  ServiceData(
      {this.attachments,
      this.bookingDate,
      this.bookingSlot,
      this.categoryId,
      this.categoryName,
      this.cityId,
      this.description,
      this.bookingDay,
      this.discount,
      this.duration,
      this.isSlot,
      this.id,
      this.bookingSlots,
      this.isFeatured,
      this.name,
      this.price,
      this.pricePerSqft,
      this.providerId,
      this.providerName,
      this.status,
      this.totalRating,
      this.totalReview,
      this.providerImage,
      this.type,
      this.isFavourite,
      this.serviceAddressMapping,
      this.subCategoryName,
      this.createdAt,
      this.customerName,
      this.serviceAttachments,
      this.serviceId,
      this.userId,
      this.dateTimeVal,
      this.bookingAddressId,
      this.servicePackage,
      this.isEnableAdvancePayment,
      this.advancePaymentPercentage,
      this.advancePaymentAmount,
      this.customizable,
      this.options});

  factory ServiceData.fromJson(Map<String, dynamic> json) {
    return ServiceData(
      id: json['id'],
      name: json['name'],
      categoryId: json['category_id'],
      providerId: json['provider_id'],
      price: json['price'],
      pricePerSqft: json['price_per_sqft'],
      type: json['type'],
      bookingDate: json['booking_date'],
      bookingSlot: json['booking_slot'],
      bookingDay: json['booking_day'],
      isSlot: json['is_slot'],
      subCategoryName: json['subcategory_name'],
      discount: json['discount'],
      duration: json['duration'],
      status: json['status'],
      description: json['description'],
      isFeatured: json['is_featured'],
      providerName: json['provider_name'],
      categoryName: json['category_name'],
      attachments: json['attchments'] != null
          ? new List<String>.from(json['attchments'])
          : null,
      totalReview: json['total_review'],
      totalRating: json['total_rating'],
      isFavourite: json['is_favourite'],
      cityId: json['city_id'],
      providerImage: json['provider_image'],
      serviceAddressMapping: json['service_address_mapping'] != null
          ? (json['service_address_mapping'] as List)
              .map((i) => ServiceAddressMapping.fromJson(i))
              .toList()
          : null,
      bookingSlots: json['slots'] != null
          ? (json['slots'] as List).map((i) => SlotData.fromJson(i)).toList()
          : null,
      createdAt: json['created_at'],
      customerName: json['customer_name'],
      serviceAttachments: json['service_attchments'] != null
          ? new List<String>.from(json['service_attchments'])
          : null,
      serviceId: json['service_id'],
      userId: json['user_id'],
      servicePackage: json['servicePackage'] != null
          ? (json['servicePackage'] as List)
              .map((i) => BookingPackage.fromJson(i))
              .toList()
          : null,
      options: json['options'] != null
          ? (json['options'] as List).map((i) => Option.fromJson(i)).toList()
          : null,
      isEnableAdvancePayment: json[AdvancePaymentKey.isEnableAdvancePayment],
      advancePaymentPercentage: json[AdvancePaymentKey.advancePaymentAmount],
      customizable: json['customizable'],
      advancePaymentAmount: json['advance_payment_amount'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['city_id'] = this.cityId;
    data['description'] = this.description;
    data['discount'] = this.discount;
    data['booking_date'] = this.bookingDate;
    data['booking_slot'] = this.bookingSlot;
    data['booking_day'] = this.bookingDay;
    data['slots'] = this.bookingSlots;
    data['duration'] = this.duration;
    data['id'] = this.id;
    data['is_featured'] = this.isFeatured;
    data['name'] = this.name;
    data['price'] = this.price;
    data['price_per_sqft'] = this.pricePerSqft;
    data['is_slot'] = this.isSlot;
    // data['price_format'] = this.priceFormat;
    data['provider_id'] = this.providerId;
    data['provider_name'] = this.providerName;
    data['status'] = this.status;
    data['total_rating'] = this.totalRating;
    data['total_review'] = this.totalReview;
    data['provider_image'] = this.providerImage;
    data['subcategory_name'] = this.subCategoryName;
    data['created_at'] = this.createdAt;
    data['customer_name'] = this.customerName;
    data['service_id'] = this.serviceId;
    data['customizable'] = this.customizable;
    data['user_id'] = this.userId;
    data['type'] = this.type;
    if (this.serviceAttachments != null) {
      data['service_attchments'] = this.serviceAttachments;
    }
    if (this.attachments != null) {
      data['attchments'] = this.attachments;
    }
    data['is_favourite'] = this.isFavourite;
    if (this.serviceAddressMapping != null) {
      data['service_address_mapping'] =
          this.serviceAddressMapping!.map((v) => v.toJson()).toList();
    }

    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }

    if (this.servicePackage != null) {
      data['servicePackage'] =
          this.servicePackage!.map((v) => v.toJson()).toList();
    }
    data[AdvancePaymentKey.isEnableAdvancePayment] = this.isAdvancePayment;
    data[AdvancePaymentKey.advancePaymentAmount] =
        this.advancePaymentPercentage;
    data['advance_payment_amount'] = this.advancePaymentAmount;
    return data;
  }
}

class Option {
  int? id;
  String? name;
  int? multi;
  String? type;
  int? typeInt;
  int? unitPrice;
  int? area;
  bool? customizable;
  List<Variant>? variants;

  Option(
      {this.id,
      this.name,
      this.multi,
      this.type,
      this.typeInt,
      this.unitPrice,
      this.area,
      this.customizable,
      this.variants});

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
        id: json['id'],
        name: json['name'],
        multi: json['multi'],
        type: json['type'],
        typeInt: json['type_int'],
        unitPrice: json['unit_price'],
        area: json['area'],
        customizable: json['customizable'],
        variants: json['variants'] != null
            ? (json['variants'] as List)
                .map((i) => Variant.fromJson(i))
                .toList()
            : null);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['multi'] = this.multi;
    data['type'] = this.type;
    data['type_int'] = this.typeInt;
    data['unit_price'] = this.unitPrice;
    data['area'] = this.area;
    data['customizable'] = this.customizable;
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Variant {
  int? id;
  String? name;
  int? price;
  int? packageArea;
  String? priceFormat;
  bool? showDescription;
  String? description;

  Variant(
      {this.id,
      this.name,
      this.price,
      this.packageArea,
      this.priceFormat,
      this.description,
      this.showDescription});

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        priceFormat: json['price_format'],
        packageArea: json['package_area'],
        description: json['description'],
        showDescription: json['show_description']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['price_format'] = this.priceFormat;
    data['package_area'] = this.packageArea;
    data['description'] = this.description;
    data['show_description'] = this.showDescription;
    return data;
  }
}

class ServiceAddressMapping {
  int? id;
  int? serviceId;
  int? providerAddressId;
  String? createdAt;
  String? updatedAt;
  ProviderAddressMapping? providerAddressMapping;

  ServiceAddressMapping(
      {this.id,
      this.serviceId,
      this.providerAddressId,
      this.createdAt,
      this.updatedAt,
      this.providerAddressMapping});

  ServiceAddressMapping.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceId = json['service_id'];
    providerAddressId = json['provider_address_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    providerAddressMapping = json['provider_address_mapping'] != null
        ? new ProviderAddressMapping.fromJson(json['provider_address_mapping'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_id'] = this.serviceId;
    data['provider_address_id'] = this.providerAddressId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.providerAddressMapping != null) {
      data['provider_address_mapping'] = this.providerAddressMapping!.toJson();
    }
    return data;
  }
}

class ProviderAddressMapping {
  int? id;
  int? providerId;
  String? address;
  String? latitude;
  String? longitude;
  var status;
  String? createdAt;
  String? updatedAt;

  ProviderAddressMapping(
      {this.id,
      this.providerId,
      this.address,
      this.latitude,
      this.longitude,
      this.status,
      this.createdAt,
      this.updatedAt});

  ProviderAddressMapping.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerId = json['provider_id'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['provider_id'] = this.providerId;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
