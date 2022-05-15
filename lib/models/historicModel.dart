class Historic {
  String? placeId;

  DateTime? start;
  DateTime? end;

  Historic({
    this.placeId,
    this.start,
    this.end,
  });
  factory Historic.fromJson(Map<String, dynamic> json) => Historic(
        start: json["start"].toDate(),
        end: json["end"].toDate(),
      );
  Map<String, dynamic> toJson() {
    return {
      "placeId": placeId,
      "start": start,
      "end": end,
    };
  }
}
