class TaxModel {
  int? id;
  int? providerId;
  String? title;
  String? type;
  num? value;
  bool? seperate;
  num? totalCalculatedValue;

  TaxModel(
      {this.id,
      this.providerId,
      this.title,
      this.value,
      this.type,
      this.seperate,
      this.totalCalculatedValue});

  factory TaxModel.fromJson(Map<String, dynamic> json) {
    return TaxModel(
        id: json['id'],
        providerId: json['provider_id'],
        seperate: json['seperate'],
        title: json['title'],
        type: json['type'],
        value: json['value']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.id != null) data['id'] = this.id;
    if (this.providerId != null) data['provider_id'] = this.providerId;
    if (this.title != null) data['title'] = this.title;
    if (this.type != null) data['type'] = this.type;
    if (this.value != null) data['value'] = this.value;
    if (this.seperate != null) data['seperate'] = this.seperate;
    return data;
  }
}

class TaxDetailResponse {
  List<TaxModel>? taxData;
  TaxDetailResponse({this.taxData});
  factory TaxDetailResponse.fromJson(Map<String, dynamic> json) {
    return TaxDetailResponse(taxData: json as List<TaxModel>);
  }

  Map<String, dynamic> toJson() {
    if (this.taxData != null) {
      return this.taxData as Map<String, dynamic>;
    } else {
      return {};
    }
  }
}
