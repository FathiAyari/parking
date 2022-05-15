class EndUser {
  EndUser(
      {this.username,
      this.lastname,
      this.email,
      this.phone,
      this.uid,
      this.role,
      this.registration,
      this.expirationDate,
      this.ccv,
      this.cardHolder,
      this.creditCard});

  String? uid;
  String? username;
  String? cardHolder;
  String? lastname;
  String? email;
  String? phone;
  String? role;
  String? registration;
  String? creditCard;
  String? expirationDate;
  String? ccv;

  factory EndUser.fromJson(Map<String, dynamic> json) => EndUser(
        uid: json["uid"],
        username: json["username"],
        lastname: json["lastname"],
        email: json["email"],
        phone: json["phone"],
        role: json["role"],
        registration: json["registration"],
        creditCard: json["creditCard"],
        ccv: json["ccv"],
        cardHolder: json["cardHolder"],
        expirationDate: json["expirationDate"],
      );

  Map<String, dynamic> toJsonUpdate() => {
        "username": username,
        "phone": phone,
      };

  Map<String, dynamic> toJson(String type) => {
        "uid": uid,
        "username": username,
        "lastname": lastname,
        "email": email,
        "phone": phone,
        "cardHolder": cardHolder,
        "role": type,
        "registration": registration,
        "ccv": ccv,
        "creditCard": creditCard,
        "expirationDate": expirationDate,
      };
}
