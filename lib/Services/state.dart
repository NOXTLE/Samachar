import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class MyState extends ChangeNotifier {
  List<String> categories = [
    "Headlines",
    "Technology",
    "Sports",
    "business",
    "Entertainment",
    "Science"
  ];

  var selected_index = 0;
  var selected_color = Colors.grey[300];

  void select(int index) {
    selected_index = index;
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }

  Future Headlines() async {
    var headline = await Dio().get(selected_index == 0
        ? 'https://newsapi.org/v2/everything?q=politics&from=2024-02-17&to=2024-02-17&sortBy=popularity&apiKey=a60c1c317865446a8433f3cec7fe5796'
        : 'https://newsapi.org/v2/everything?q=${categories[selected_index]}&from=2024-02-17&to=2024-02-17&sortBy=popularity&apiKey=a60c1c317865446a8433f3cec7fe5796');

    print(headline.data);
    print(categories[selected_index]);
    return headline.data;
  }
}
