class SignInRequest {
  final String mobileNo;
  final String roleId;
  final String fcmKey;

  SignInRequest({
    required this.mobileNo,
    required this.roleId,
    required this.fcmKey,
  });

  // Convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      'mobile_no': mobileNo,
      'role_id': roleId,
      'fcm_key': fcmKey,
    };
  }
}

class SignInResponse {
  final bool? success;
  final Data? data;
  final String? message;

  SignInResponse({
    this.success,
    this.data,
    this.message,
  });

  // fromJson method to parse the response
  factory SignInResponse.fromJson(Map<String, dynamic> json) {
    return SignInResponse(
      success: json['success'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      message: json['message'],
    );
  }

  // toJson method for serializing the object back to JSON (optional, for sending data)
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
      'message': message,
    };
  }
}

class Data {
  final String? mobileNo;
  final String? roleId;
  final int? id;
  final String? token;
  final dynamic fcmKey;
  final String? profileStatus;
  final String? partnerDocument;
  final String? vehicleDocument;
  final String? categoryStatus;
  final String? approveStatus;

  Data({
    required this.mobileNo,
    this.roleId,
    this.id,
    this.token,
    this.fcmKey,
    this.profileStatus,
    this.partnerDocument,
    this.vehicleDocument,
    this.categoryStatus,
    this.approveStatus,
  });

  // fromJson method to parse the data object
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      mobileNo: json['mobile_no'],
      roleId: json['role_id'],
      id: json['id'],
      token: json['token'],
      fcmKey: json['fcm_key'],
      profileStatus: json['profile_status'],
      partnerDocument: json['partner_document'],
      vehicleDocument: json['vehicle_document'],
      categoryStatus: json['category_status'],
      approveStatus: json['approve_status'],
    );
  }

  // toJson method for serializing the object back to JSON (optional, for sending data)
  Map<String, dynamic> toJson() {
    return {
      'mobile_no': mobileNo,
      'role_id': roleId,
      'id': id,
      'token': token,
      'fcm_key': fcmKey,
      'profile_status': profileStatus,
      'partner_document': partnerDocument,
      'vehicle_document': vehicleDocument,
      'category_status': categoryStatus,
      'approve_status': approveStatus,
    };
  }
}
