class Reservation {
  String? userId;
  String? placeId;
  String? floorId;
  DateTime? start;
  DateTime? end;
  int? index;

  Reservation(
      {this.userId,
      this.placeId,
      this.floorId,
      this.start,
      this.end,
      this.index});

  factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
        floorId: json["floorId"],
        userId: json["userId"],
        placeId: json["placeId"],
        index: json["index"],
        start: json["start"].toDate(),
        end: json["end"].toDate(),
      );
  Map<String, dynamic> toJson() {
    return {
      "placeId": placeId,
      "userId": userId,
      "userId": userId,
      "start": start,
      "end": end,
      "index": index,
    };
  }
}
