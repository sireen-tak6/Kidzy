//import 'package:version_1/model/article.dart';
import 'package:version_1/model/articles.dart';

class f {
  final token;
  final surl;
  f(this.token, this.surl);

  Future<dynamic> fe() async {
    return get(token, surl);
  }
}
