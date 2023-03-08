class IssuesResponse {
  int? draw;
  int? recordsTotal;
  int? recordsFiltered;
  Issues? data;

  IssuesResponse(
      {this.draw, this.recordsTotal, this.recordsFiltered, this.data});

  IssuesResponse.fromJson(Map<String, dynamic> json) {
    draw = json['draw'];
    recordsTotal = json['recordsTotal'];
    recordsFiltered = json['recordsFiltered'];
    data = json['data'] != null ? new Issues.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['draw'] = this.draw;
    data['recordsTotal'] = this.recordsTotal;
    data['recordsFiltered'] = this.recordsFiltered;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Issues {
  String? id;
  String? caseId;
  String? agentId;
  String? profileId;
  String? agentName;
  String? creationDate;
  String? issueCategory;
  String? issueCategoryName;
  String? issueSubCategory;
  String? issueSubCategoryName;
  String? status;
  String? resolutionDeadline;
  String? createdBy;
  var supportingFiles;
  var cleverResponse;
  int? sla;
  String? acknowledgedTime;
  int? acknowledgementTime;
  String? acknowledgedBy;
  String? createdAt;
  String? updatedAt;
  String? closedDate;
  int? slaPerformance;
  String? transactionDate;
  int? cardPan;
  String? pan;
  String? cardName;
  int? transactionAmount;
  String? cardHolderPhoneNumber;
  String? receipt;
  String? agentFirstName;
  String? agentLastName;
  String? createdByFirstName;
  String? createdByLastName;
  String? acknowledgedByFirstName;
  String? acknowledgedByLastName;
  bool? confirmSettlement;
  var agentTerminalId;
  var issueDescription;
  var eattestationForm;

  Issues({
    this.id,
    this.caseId,
    this.agentId,
    this.profileId,
    this.agentName,
    this.creationDate,
    this.issueCategory,
    this.issueCategoryName,
    this.issueSubCategory,
    this.issueSubCategoryName,
    this.status,
    this.resolutionDeadline,
    this.createdBy,
    this.supportingFiles,
    this.cleverResponse,
    this.sla,
    this.acknowledgedTime,
    this.acknowledgementTime,
    this.acknowledgedBy,
    this.createdAt,
    this.updatedAt,
    this.closedDate,
    this.slaPerformance,
    this.transactionDate,
    this.cardPan,
    this.pan,
    this.cardName,
    this.transactionAmount,
    this.cardHolderPhoneNumber,
    this.receipt,
    this.agentFirstName,
    this.agentLastName,
    this.createdByFirstName,
    this.createdByLastName,
    this.acknowledgedByFirstName,
    this.acknowledgedByLastName,
    this.confirmSettlement,
    this.agentTerminalId,
    this.issueDescription,
    this.eattestationForm,
  });

  Issues.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    caseId = json['caseId'];
    agentId = json['agentId'];
    profileId = json['profileId'];
    agentName = json['agentName'];
    creationDate = json['creationDate'];
    issueCategory = json['issueCategory'];
    issueCategoryName = json['issueCategoryName'];
    issueSubCategory = json['issueSubCategory'];
    issueSubCategoryName = json['issueSubCategoryName'];
    status = json['status'];
    resolutionDeadline = json['resolutionDeadline'];
    createdBy = json['createdBy'];
    supportingFiles = json['supportingFiles'];
    cleverResponse = json['cleverResponse'];
    sla = json['sla'];
    acknowledgedTime = json['acknowledgedTime'];
    acknowledgementTime = json['acknowledgementTime'];
    acknowledgedBy = json['acknowledgedBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    closedDate = json['closedDate'];
    slaPerformance = json['slaPerformance'];
    transactionDate = json['transactionDate'];
    cardPan = json['cardPan'];
    pan = json['pan'];
    cardName = json['cardName'];
    transactionAmount = json['transactionAmount'];
    cardHolderPhoneNumber = json['cardHolderPhoneNumber'];
    receipt = json['receipt'];
    agentFirstName = json['agentFirstName'];
    agentLastName = json['agentLastName'];
    createdByFirstName = json['createdByFirstName'];
    createdByLastName = json['createdByLastName'];
    acknowledgedByFirstName = json['acknowledgedByFirstName'];
    acknowledgedByLastName = json['acknowledgedByLastName'];
    confirmSettlement = json['confirmSettlement'];
    agentTerminalId = json['agentTerminalId'];
    issueDescription = json['issueDescription'];
    eattestationForm = json['eattestationForm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['caseId'] = this.caseId;
    data['agentId'] = this.agentId;
    data['profileId'] = this.profileId;
    data['agentName'] = this.agentName;
    data['creationDate'] = this.creationDate;
    data['issueCategory'] = this.issueCategory;
    data['issueCategoryName'] = this.issueCategoryName;
    data['issueSubCategory'] = this.issueSubCategory;
    data['issueSubCategoryName'] = this.issueSubCategoryName;
    data['status'] = this.status;
    data['resolutionDeadline'] = this.resolutionDeadline;
    data['createdBy'] = this.createdBy;
    data['supportingFiles'] = this.supportingFiles;
    data['cleverResponse'] = this.cleverResponse;
    data['sla'] = this.sla;
    data['acknowledgedTime'] = this.acknowledgedTime;
    data['acknowledgementTime'] = this.acknowledgementTime;
    data['acknowledgedBy'] = this.acknowledgedBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['closedDate'] = this.closedDate;
    data['slaPerformance'] = this.slaPerformance;
    data['transactionDate'] = this.transactionDate;
    data['cardPan'] = this.cardPan;
    data['pan'] = this.pan;
    data['cardName'] = this.cardName;
    data['transactionAmount'] = this.transactionAmount;
    data['cardHolderPhoneNumber'] = this.cardHolderPhoneNumber;
    data['receipt'] = this.receipt;
    data['agentFirstName'] = this.agentFirstName;
    data['agentLastName'] = this.agentLastName;
    data['createdByFirstName'] = this.createdByFirstName;
    data['createdByLastName'] = this.createdByLastName;
    data['acknowledgedByFirstName'] = this.acknowledgedByFirstName;
    data['acknowledgedByLastName'] = this.acknowledgedByLastName;
    data['confirmSettlement'] = this.confirmSettlement;
    data['agentTerminalId'] = this.agentTerminalId;
    data['issueDescription'] = this.issueDescription;
    data['eattestationForm'] = this.eattestationForm;
    return data;
  }

  static getList(List<dynamic>? json) {
    List<Map<String, dynamic>> issue =
        List<Map<String, dynamic>>.from(json ?? []);
    return List.generate(
        issue.length, (index) => Issues.fromJson(issue[index]));
  }
}
