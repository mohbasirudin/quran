class ApiShalat {
  static String _baseUrl = "https://api.myquran.com/v1/sholat/";

  static String kota({String search = ""}) {
    if (search.isNotEmpty) {
      return "$_baseUrl/kota/cari/$search";
    } else {
      return "$_baseUrl/kota/semua";
    }
  }

  static String jadwal({required var kota, required var date}) =>
      "$_baseUrl/jadwal/$kota/$date";
}
