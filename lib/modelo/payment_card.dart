class PaymentCard {
  final String titleName;
  final String numberCard;
  final String email;
  final String dateExpire;
  final String securityNumber;
  final String cardNickname;

  PaymentCard({
    required this.titleName,
    required this.numberCard,
    required this.email,
    required this.dateExpire,
    required this.securityNumber,
    required this.cardNickname,
  });

  Map<String, dynamic> toMap() {
    return {
      'titleName': titleName,
      'numberCard': numberCard,
      'email': email,
      'dateExpire': dateExpire,
      'securityNumber': securityNumber,
      'cardNickname': cardNickname,
    };
  }

  factory PaymentCard.fromMap(Map<String, dynamic> map) {
    return PaymentCard(
      titleName: map['titleName'],
      numberCard: map['numberCard'],
      email: map['email'],
      dateExpire: map['dateExpire'],
      securityNumber: map['securityNumber'],
      cardNickname: map['cardNickname'],
    );
  }
}
