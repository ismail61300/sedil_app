class Lort {
  final String lTime;
  final String rTime;
  final String lrTime;
  final String lorType;

  Lort(this.lTime, this.rTime, this.lrTime, this.lorType);

  Lort.fromJson(Map<String, dynamic> json)
      : lTime = json["lTime"],
        rTime = json["rTime"],
        lrTime = json["lrTime"],
        lorType = json["lorType"];

  Map<String, dynamic> toJson() => {
    "lTime" : lTime,
    "rTime" : rTime,
    "lrTime" : lrTime,
    "lorType" : lorType,
  };
}
