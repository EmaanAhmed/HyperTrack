//HTTP return codes cheat sheet
// 1** Hold on
// 2** Here you go
// 3** Go away
// 4** You fucked up
// 5** I fucked up

import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper({this.url, this.auth, this.id});
  final String url;
  final String auth;
  final String id;

  Future startTracing() async {
    http.Response response = await http.post('$url/devices/$id/start',
        body: null, headers: {'Authorization': auth});
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }

  Future getData() async {
    http.Response response =
        await http.get('$url/devices/$id', headers: {'Authorization': auth});
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }

  Future endTracing() async {
    http.Response response = await http.post('$url/devices/$id/stop',
        body: null, headers: {'Authorization': auth});
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
