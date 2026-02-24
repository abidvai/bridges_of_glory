class PaypalPayModel {
  final String approvalUrl;

  PaypalPayModel({required this.approvalUrl});

  factory PaypalPayModel.fromJson(Map<String, dynamic> json) =>
      PaypalPayModel(approvalUrl: json["approvalUrl"]);

  Map<String, dynamic> toJson() => {"approvalUrl": approvalUrl};
}
