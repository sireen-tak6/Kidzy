/*import 'package:http/http.dart' as http;
import 'dart:convert';

class article {
  int id;
  String Title;
  String Content;
  String website;
  String Age;
  String Publish_date;
  article(
    this.id,
    this.Title,
    this.Content,
    this.website,
    this.Age,
    this.Publish_date,
  );
}

geta(id) async {
  var client = http.Client();
  var response;

  try {
    response = await http.get(Uri.parse("http://192.168.1.35:8000/articals"));
    var l = jsonDecode(response.body);

    return l["articals"];
  } catch (e) {
    print(e);
  }
}*/
