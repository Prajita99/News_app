import 'package:http/http.dart' as http;
import 'package:news_app/config/config.dart';
import 'package:news_app/models/news_model.dart';

class NewsApi {
  Future getAllNews () async {
    try{
      Uri url = Uri.parse(
        "${Config.apiBaseUrl}/everything?q=bitcoin&apiKey=de46541d57174eff8161156f9d1deffc"
        );
      //api response
      var response= await http.get(
        url,
        headers: {
          'Accept': 'application/json',
        },
        );
        print(response.body);
        if(response.statusCode == 200) {
          return newsModelFromJson(response.body);
        }
    } catch(e) {
      print(e.toString());
    }
  }
}
