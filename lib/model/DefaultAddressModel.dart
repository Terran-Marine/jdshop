class DefaultAddressModel {
  bool success;
  String message;
  List<DefaultAddressItemModel> result;

  DefaultAddressModel({this.success, this.message, this.result});

  DefaultAddressModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['result'] != null) {
      result = new List<DefaultAddressItemModel>();
      json['result'].forEach((v) {
        result.add(new DefaultAddressItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'DefaultAddressModel{success: $success, message: $message, result: $result}';
  }
}

class DefaultAddressItemModel {
  String sId;
  String uid;
  String name;
  String phone;
  String address;
  int defaultAddress;
  int status;
  int addTime;

  DefaultAddressItemModel(
      {this.sId,
        this.uid,
        this.name,
        this.phone,
        this.address,
        this.defaultAddress,
        this.status,
        this.addTime});

  DefaultAddressItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    uid = json['uid'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    defaultAddress = json['default_address'];
    status = json['status'];
    addTime = json['add_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['default_address'] = this.defaultAddress;
    data['status'] = this.status;
    data['add_time'] = this.addTime;
    return data;
  }

  @override
  String toString() {
    return 'DefaultAddressItemModel{sId: $sId, uid: $uid, name: $name, phone: $phone, address: $address, defaultAddress: $defaultAddress, status: $status, addTime: $addTime}';
  }
}
