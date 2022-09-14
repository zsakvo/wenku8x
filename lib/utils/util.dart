class Util {
  static getCover(String aid) {
    int ia = int.parse(aid);
    return "https://img.wenku8.com/image/${ia ~/ 1000}/$aid/${aid}s.jpg";
  }
}
