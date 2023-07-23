class User {
  bool? status;
  Null responseCode;
  String? message;
  Data? data;

  User({this.status, this.responseCode, this.message, this.data});

  User.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    responseCode = json['responseCode'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['responseCode'] = this.responseCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? agentId;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? businessName;
  String? bvn;
  String? nin;
  String? profilePicture;
  String? utilityBill;
  String? identityCard;
  Null roleGroup;
  List<String>? roles;
  String? userType;
  String? gender;
  String? dateOfBirth;
  String? verificationStatus;
  String? approvalStatus;
  bool? enabled;
  bool? verified;
  String? address;
  String? city;
  String? lga;
  String? state;
  String? terminalId;
  String? bankTID;
  String? deviceSerialNumber;
  TerminalInfo? terminalInfo;
  String? accountNumber;
  String? wemaAccountNumber;
  String? providusAccountNumber;
  String? pageAccountNumber;
  String? displayedAccount;
  double? msc;
  bool? hasPin;
  String? businessManager;
  String? lastLogin;
  String? aggregatorId;
  int? numberOfChangeTransactionPinAttempts;
  Null metaMapInfo;
  String? fullName;
  bool? changeTransactionAttemptsExceeded;
  int? remainingChangeTransactionPinAttempts;

  Data(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.agentId,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.businessName,
      this.bvn,
      this.nin,
      this.profilePicture,
      this.utilityBill,
      this.identityCard,
      this.roleGroup,
      this.roles,
      this.userType,
      this.gender,
      this.dateOfBirth,
      this.verificationStatus,
      this.approvalStatus,
      this.enabled,
      this.verified,
      this.address,
      this.city,
      this.lga,
      this.state,
      this.terminalId,
      this.bankTID,
      this.deviceSerialNumber,
      this.terminalInfo,
      this.accountNumber,
      this.wemaAccountNumber,
      this.providusAccountNumber,
      this.pageAccountNumber,
      this.displayedAccount,
      this.msc,
      this.hasPin,
      this.businessManager,
      this.lastLogin,
      this.aggregatorId,
      this.numberOfChangeTransactionPinAttempts,
      this.metaMapInfo,
      this.fullName,
      this.changeTransactionAttemptsExceeded,
      this.remainingChangeTransactionPinAttempts});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    agentId = json['agentId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    businessName = json['businessName'];
    bvn = json['bvn'];
    nin = json['nin'];
    profilePicture = json['profilePicture'];
    utilityBill = json['utilityBill'];
    identityCard = json['identityCard'];
    roleGroup = json['roleGroup'];
    roles = json['roles'].cast<String>();
    userType = json['userType'];
    gender = json['gender'];
    dateOfBirth = json['dateOfBirth'];
    verificationStatus = json['verificationStatus'];
    approvalStatus = json['approvalStatus'];
    enabled = json['enabled'];
    verified = json['verified'];
    address = json['address'];
    city = json['city'];
    lga = json['lga'];
    state = json['state'];
    terminalId = json['terminalId'];
    bankTID = json['bankTID'];
    deviceSerialNumber = json['deviceSerialNumber'];
    terminalInfo = json['terminalInfo'] != null
        ? new TerminalInfo.fromJson(json['terminalInfo'])
        : null;
    accountNumber = json['accountNumber'];
    wemaAccountNumber = json['wemaAccountNumber'];
    providusAccountNumber = json['providusAccountNumber'];
    pageAccountNumber = json['pageAccountNumber'];
    displayedAccount = json['displayedAccount'];
    msc = json['msc'];
    hasPin = json['hasPin'];
    businessManager = json['businessManager'];
    lastLogin = json['lastLogin'];
    aggregatorId = json['aggregatorId'];
    numberOfChangeTransactionPinAttempts =
        json['numberOfChangeTransactionPinAttempts'];
    metaMapInfo = json['metaMapInfo'];
    fullName = json['fullName'];
    changeTransactionAttemptsExceeded =
        json['changeTransactionAttemptsExceeded'];
    remainingChangeTransactionPinAttempts =
        json['remainingChangeTransactionPinAttempts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['agentId'] = this.agentId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['businessName'] = this.businessName;
    data['bvn'] = this.bvn;
    data['nin'] = this.nin;
    data['profilePicture'] = this.profilePicture;
    data['utilityBill'] = this.utilityBill;
    data['identityCard'] = this.identityCard;
    data['roleGroup'] = this.roleGroup;
    data['roles'] = this.roles;
    data['userType'] = this.userType;
    data['gender'] = this.gender;
    data['dateOfBirth'] = this.dateOfBirth;
    data['verificationStatus'] = this.verificationStatus;
    data['approvalStatus'] = this.approvalStatus;
    data['enabled'] = this.enabled;
    data['verified'] = this.verified;
    data['address'] = this.address;
    data['city'] = this.city;
    data['lga'] = this.lga;
    data['state'] = this.state;
    data['terminalId'] = this.terminalId;
    data['bankTID'] = this.bankTID;
    data['deviceSerialNumber'] = this.deviceSerialNumber;
    if (this.terminalInfo != null) {
      data['terminalInfo'] = this.terminalInfo!.toJson();
    }
    data['accountNumber'] = this.accountNumber;
    data['wemaAccountNumber'] = this.wemaAccountNumber;
    data['providusAccountNumber'] = this.providusAccountNumber;
    data['pageAccountNumber'] = this.pageAccountNumber;
    data['displayedAccount'] = this.displayedAccount;
    data['msc'] = this.msc;
    data['hasPin'] = this.hasPin;
    data['businessManager'] = this.businessManager;
    data['lastLogin'] = this.lastLogin;
    data['aggregatorId'] = this.aggregatorId;
    data['numberOfChangeTransactionPinAttempts'] =
        this.numberOfChangeTransactionPinAttempts;
    data['metaMapInfo'] = this.metaMapInfo;
    data['fullName'] = this.fullName;
    data['changeTransactionAttemptsExceeded'] =
        this.changeTransactionAttemptsExceeded;
    data['remainingChangeTransactionPinAttempts'] =
        this.remainingChangeTransactionPinAttempts;
    return data;
  }
}

class TerminalInfo {
  List<String>? deviceSerialNumber;
  List<String>? terminalID;

  TerminalInfo({this.deviceSerialNumber, this.terminalID});

  TerminalInfo.fromJson(Map<String, dynamic> json) {
    deviceSerialNumber = json['deviceSerialNumber'].cast<String>();
    terminalID = json['terminalID'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deviceSerialNumber'] = this.deviceSerialNumber;
    data['terminalID'] = this.terminalID;
    return data;
  }
}
