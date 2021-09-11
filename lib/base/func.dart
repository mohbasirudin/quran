class BaseFunc {
  static int timeToInt({required String time}) {
    var data = time.split(":");
    if (data.length > 2 && data.length <= 3) {
      return (int.parse(data[0]) * 3600) +
          (int.parse(data[1]) * 60) +
          int.parse(data[2]);
    } else if (data.length > 1 && data.length <= 2) {
      return (int.parse(data[0]) * 3600) + (int.parse(data[1]) * 60);
    } else {
      return int.parse(data[0]);
    }
  }
}
