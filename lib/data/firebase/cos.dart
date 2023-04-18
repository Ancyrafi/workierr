import 'package:http/http.dart' as http;
import 'dart:convert';


Future<List<String>> getPlaceSuggestions(String input) async {
  String apiKey = "AIzaSyCPxQasQqeuClVVBTCHOESCjo5wolDLEpI";
  String apiUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=geocode&key=$apiKey";

  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse["status"] == "OK") {
      List<dynamic> predictions = jsonResponse["predictions"];
      return predictions.map((prediction) => prediction["description"]).toList().cast<String>();
    } else {
      throw Exception('Failed to get place suggestions');
    }
  } else {
    throw Exception('Failed to get place suggestions');
  }
}