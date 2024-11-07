class CreditCard {
  final String cardNumber;
  final String cardHolderName;
  final String expirationDate;
  final String cvv;
  final String? nickname;
  CreditCard({
    required this.cardNumber,
    required this.cardHolderName,
    required this.expirationDate,
    required this.cvv,
    this.nickname,
  });


  Map<String, dynamic> toMap() {
    return {
      'cardNumber': cardNumber,
      'cardHolderName': cardHolderName,
      'expirationDate': expirationDate,
      'cvv': cvv,
      'nickname': nickname ?? '',
    };
  }


  factory CreditCard.fromMap(Map<String, dynamic> map) {
    return CreditCard(
      cardNumber: map['cardNumber'],
      cardHolderName: map['cardHolderName'],
      expirationDate: map['expirationDate'],
      cvv: map['cvv'],
      nickname: map['nickname'],
    );
  }
  @override
  String toString() {
    return 'CreditCard(cardNumber: $cardNumber, cardHolderName: $cardHolderName, expirationDate: $expirationDate, nickname: ${nickname ?? 'N/A'})';
  }
}