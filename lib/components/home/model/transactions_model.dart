class TransactionsResponse {
  int? draw;
  int? recordsTotal;
  int? recordsFiltered;
  List<Transactions>? data;

  TransactionsResponse(
      {this.draw, this.recordsTotal, this.recordsFiltered, this.data});

  TransactionsResponse.fromJson(Map<String, dynamic> json) {
    draw = json['draw'];
    recordsTotal = json['recordsTotal'];
    recordsFiltered = json['recordsFiltered'];
    if (json['data'] != null) {
      data = <Transactions>[];
      json['data'].forEach((v) {
        data!.add(new Transactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['draw'] = this.draw;
    data['recordsTotal'] = this.recordsTotal;
    data['recordsFiltered'] = this.recordsFiltered;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transactions {
  String? id;
  String? userID;
  String? aggregatorID;
  String? firstName;
  String? lastName;
  String? ref;
  String? transactionID;
  num? totalAmount;
  num? transactionAmount;
  var transactionFee;
  var actionableAmount;
  num? aggregatorCut;
  var cleverCut;
  var providerFee;
  String? type;
  String? responseCode;
  String? responseMessage;
  double? preBalance;
  double? postBalance;
  num? walletHistoryID;
  num? walletID;
  num? walletActionAt;
  String? narration;
  String? providerReference;
  String? uniqueTransactionID;
  String? provider;
  String? slug;
  String? bundle;
  String? group;
  String? transactionDateTime;
  String? createdAt;
  String? updatedAt;
  String? businessManager;
  String? rrn;
  String? pan;
  String? terminalID;
  String? agentID;
  String? beneficiaryName;
  String? beneficiaryAccountNumber;
  String? beneficiaryBankName;
  String? sessionID;
  String? status;
  var agentCut;
  String? bouquetCode;
  String? smartCardNumber;
  String? bouquetName;
  bool? debited;
  bool? tracked;
  String? billerPackage;
  String? billerGroup;
  String? originatorAccountNumber;
  String? originatorName;
  String? bankName;
  String? multiTransferBatchID;
  String? phoneNumber;
  String? networkProvider;
  String? serviceType;
  String? accountNumber;

  Transactions(
      {this.id,
      this.userID,
      this.aggregatorID,
      this.firstName,
      this.lastName,
      this.ref,
      this.transactionID,
      this.totalAmount,
      this.transactionAmount,
      this.transactionFee,
      this.actionableAmount,
      this.aggregatorCut,
      this.cleverCut,
      this.providerFee,
      this.type,
      this.responseCode,
      this.responseMessage,
      this.preBalance,
      this.postBalance,
      this.walletHistoryID,
      this.walletID,
      this.walletActionAt,
      this.narration,
      this.providerReference,
      this.uniqueTransactionID,
      this.provider,
      this.slug,
      this.bundle,
      this.group,
      this.transactionDateTime,
      this.createdAt,
      this.updatedAt,
      this.businessManager,
      this.rrn,
      this.pan,
      this.terminalID,
      this.agentID,
      this.beneficiaryName,
      this.beneficiaryAccountNumber,
      this.beneficiaryBankName,
      this.sessionID,
      this.status,
      this.agentCut,
      this.bouquetCode,
      this.smartCardNumber,
      this.bouquetName,
      this.debited,
      this.tracked,
      this.billerPackage,
      this.billerGroup,
      this.originatorAccountNumber,
      this.originatorName,
      this.bankName,
      this.multiTransferBatchID,
      this.phoneNumber,
      this.networkProvider,
      this.serviceType,
      this.accountNumber});

  Transactions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userID = json['userID'];
    aggregatorID = json['aggregatorID'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    ref = json['ref'];
    transactionID = json['transactionID'];
    totalAmount = json['totalAmount'];
    transactionAmount = json['transactionAmount'];
    transactionFee = json['transactionFee'];
    actionableAmount = json['actionableAmount'];
    aggregatorCut = json['aggregatorCut'];
    cleverCut = json['cleverCut'];
    providerFee = json['providerFee'];
    type = json['type'];
    responseCode = json['responseCode'];
    responseMessage = json['responseMessage'];
    preBalance = json['preBalance'];
    postBalance = json['postBalance'];
    walletHistoryID = json['walletHistoryID'];
    walletID = json['walletID'];
    walletActionAt = json['walletActionAt'];
    narration = json['narration'];
    providerReference = json['providerReference'];
    uniqueTransactionID = json['uniqueTransactionID'];
    provider = json['provider'];
    slug = json['slug'];
    bundle = json["bundle"];
    group = json["group"];
    transactionDateTime = json['transactionDateTime'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    businessManager = json['businessManager'];
    rrn = json['rrn'];
    pan = json['pan'];
    terminalID = json['terminalID'];
    agentID = json['agentID'];
    beneficiaryName = json['beneficiaryName'];
    beneficiaryAccountNumber = json['beneficiaryAccountNumber'];
    beneficiaryBankName = json['beneficiaryBankName'];
    sessionID = json['sessionID'];
    status = json['status'];
    agentCut = json['agentCut'];
    bouquetCode = json['bouquetCode'];
    smartCardNumber = json['smartCardNumber'];
    bouquetName = json['bouquetName'];
    debited = json['debited'];
    tracked = json['tracked'];
    billerPackage = json['billerPackage'];
    billerGroup = json['billerGroup'];
    originatorAccountNumber = json['originatorAccountNumber'];
    originatorName = json['originatorName'];
    bankName = json['bankName'];
    multiTransferBatchID = json['multiTransferBatchID'];
    phoneNumber = json['phoneNumber'];
    networkProvider = json['networkProvider'];
    serviceType = json['serviceType'];
    accountNumber = json['accountNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userID'] = this.userID;
    data['aggregatorID'] = this.aggregatorID;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['ref'] = this.ref;
    data['transactionID'] = this.transactionID;
    data['totalAmount'] = this.totalAmount;
    data['transactionAmount'] = this.transactionAmount;
    data['transactionFee'] = this.transactionFee;
    data['actionableAmount'] = this.actionableAmount;
    data['aggregatorCut'] = this.aggregatorCut;
    data['cleverCut'] = this.cleverCut;
    data['providerFee'] = this.providerFee;
    data['type'] = this.type;
    data['responseCode'] = this.responseCode;
    data['responseMessage'] = this.responseMessage;
    data['preBalance'] = this.preBalance;
    data['postBalance'] = this.postBalance;
    data['walletHistoryID'] = this.walletHistoryID;
    data['walletID'] = this.walletID;
    data['walletActionAt'] = this.walletActionAt;
    data['narration'] = this.narration;
    data['providerReference'] = this.providerReference;
    data['uniqueTransactionID'] = this.uniqueTransactionID;
    data['provider'] = this.provider;
    data['slug'] = this.slug;
    data['bundle'] = this.bundle;
    data['group'] = this.group;
    data['transactionDateTime'] = this.transactionDateTime;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['businessManager'] = this.businessManager;
    data['rrn'] = this.rrn;
    data['pan'] = this.pan;
    data['terminalID'] = this.terminalID;
    data['agentID'] = this.agentID;
    data['beneficiaryName'] = this.beneficiaryName;
    data['beneficiaryAccountNumber'] = this.beneficiaryAccountNumber;
    data['beneficiaryBankName'] = this.beneficiaryBankName;
    data['sessionID'] = this.sessionID;
    data['status'] = this.status;
    data['agentCut'] = this.agentCut;
    data['bouquetCode'] = this.bouquetCode;
    data['smartCardNumber'] = this.smartCardNumber;
    data['bouquetName'] = this.bouquetName;
    data['debited'] = this.debited;
    data['tracked'] = this.tracked;
    data['billerPackage'] = this.billerPackage;
    data['billerGroup'] = this.billerGroup;
    data['originatorAccountNumber'] = this.originatorAccountNumber;
    data['originatorName'] = this.originatorName;
    data['bankName'] = this.bankName;
    data['multiTransferBatchID'] = this.multiTransferBatchID;
    data['phoneNumber'] = this.phoneNumber;
    data['networkProvider'] = this.networkProvider;
    data['serviceType'] = this.serviceType;
    data['accountNumber'] = this.accountNumber;
    return data;
  }

  static getList(List<dynamic>? json) {
    List<Map<String, dynamic>> transaction =
        List<Map<String, dynamic>>.from(json ?? []);
    return List.generate(transaction.length,
        (index) => Transactions.fromJson(transaction[index]));
  }
}
