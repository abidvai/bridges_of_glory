class StripePayModel {
  final String sessionId;
  final String checkoutUrl;
  final String donationId;

  StripePayModel({
    required this.sessionId,
    required this.checkoutUrl,
    required this.donationId,
  });

  factory StripePayModel.fromJson(Map<String, dynamic> json) => StripePayModel(
    sessionId: json["sessionId"],
    checkoutUrl: json["checkoutUrl"],
    donationId: json["donation_id"],
  );

  Map<String, dynamic> toJson() => {
    "sessionId": sessionId,
    "checkoutUrl": checkoutUrl,
    "donation_id": donationId,
  };
}
