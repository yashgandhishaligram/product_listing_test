class UserEntity {
  UserEntity({
      this.userId, 
      this.fullName, 
      this.emailId, 
      this.contactNo, 
      this.fcmToken, 
      this.signalRId, 
      this.userTypeId, 
      this.status, 
      this.jwtToken, 
      this.customerKey,});

  UserEntity.fromJson(dynamic json) {
    userId = json['userId'];
    fullName = json['fullName'];
    emailId = json['emailId'];
    contactNo = json['contactNo'];
    fcmToken = json['fcmToken'];
    signalRId = json['signalRId'];
    userTypeId = json['userTypeId'];
    status = json['status'];
    jwtToken = json['jwtToken'];
    customerKey = json['customerKey'];
  }
  int? userId;
  String? fullName;
  String? emailId;
  String? contactNo;
  String? fcmToken;
  String? signalRId;
  int? userTypeId;
  int? status;
  String? jwtToken;
  String? customerKey;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['fullName'] = fullName;
    map['emailId'] = emailId;
    map['contactNo'] = contactNo;
    map['fcmToken'] = fcmToken;
    map['signalRId'] = signalRId;
    map['userTypeId'] = userTypeId;
    map['status'] = status;
    map['jwtToken'] = jwtToken;
    map['customerKey'] = customerKey;
    return map;
  }

}