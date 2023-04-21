import 'package:flutter/material.dart';
import 'package:http_requests/domain/api_clients/api_client.dart';

import 'package:http_requests/domain/entity/post.dart';

class HttpRequestExampleModel extends ChangeNotifier {
  final apiClient = ApiClient();
  var _posts = <Post>[];

  List<Post> get posts => _posts;

  Future<void> reloadPosts() async {
    final posts = await apiClient.getPosts();
    _posts += posts;
    notifyListeners();
  }

  Future<void> createPost() async {
    final posts = await apiClient.createPost(
      title: 'test title',
      body: 'test body',
    );
  }
}

class HttpRequestExampleModelProvider extends InheritedNotifier {
  final HttpRequestExampleModel model;

  const HttpRequestExampleModelProvider({
    super.key,
    required this.model,
    required Widget child,
  }) : super(
          notifier: model,
          child: child,
        );

  // Every time the model changes, the build() methods will invoke.
  static HttpRequestExampleModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<HttpRequestExampleModelProvider>();
  }

  // Get posts from model, but don't sign on changes (and will not invoke build() methods).
  static HttpRequestExampleModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<
            HttpRequestExampleModelProvider>()
        ?.widget;
    return widget is HttpRequestExampleModelProvider ? widget : null;
  }
}
