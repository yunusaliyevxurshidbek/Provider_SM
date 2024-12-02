

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/random_user_list_res.dart';
import '../services/http_service.dart';

class HomeViewModel extends ChangeNotifier{
  bool isLoading = true;
  List<RandomUser> userList = [];
  ScrollController scrollController = ScrollController();
  int currentPage = 1;

  initScrollListener(){
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent <= scrollController.offset) {
        loadRandomUserList();
      }
    });
  }

  loadRandomUserList() async {
    isLoading = true;
    notifyListeners();

    var response = await Network.GET(Network.API_RANDOM_USER_LIST, Network.paramsRandomUserList(currentPage));
    var randomUserListRes = Network.parseRandomUserList(response!);
    currentPage = randomUserListRes.info.page + 1;


      userList.addAll(randomUserListRes.results);
      isLoading = false;
      notifyListeners();

  }
}