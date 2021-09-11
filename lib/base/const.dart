class BaseConst {
  static List<String> shalat = [
    "Shubuh",
    "Dzuhur",
    "Ashar",
    "Maghrib",
    "Isya'",
  ];

  static List<int> shalatInt() {
    List<int> data = [];
    for (var i = 0; i < shalat.length; i++) {
      data.add(i);
    }
    return data;
  }
}
