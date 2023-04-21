import 'package:flutter/material.dart';

import 'package:http_requests/widgets/example/http_request_example_model.dart';

class HttpRequestExample extends StatefulWidget {
  const HttpRequestExample({super.key});

  @override
  State<HttpRequestExample> createState() => _HttpRequestExampleState();
}

class _HttpRequestExampleState extends State<HttpRequestExample> {
  final model = HttpRequestExampleModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: HttpRequestExampleModelProvider(
          model: model,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              _ReloadButton(),
              _CreateButton(),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: _PostsWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReloadButton extends StatelessWidget {
  const _ReloadButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () =>
          HttpRequestExampleModelProvider.read(context)?.model.reloadPosts(),
      child: const Text('Reload Posts'),
    );
  }
}

class _CreateButton extends StatelessWidget {
  const _CreateButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () =>
          HttpRequestExampleModelProvider.read(context)?.model.createPost(),
      child: const Text('Create Post'),
    );
  }
}

class _PostsWidget extends StatelessWidget {
  const _PostsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount:
          HttpRequestExampleModelProvider.watch(context)?.model.posts.length ??
              0,
      itemBuilder: (BuildContext context, int index) {
        return _PostsRowWidget(index: index);
      },
    );
  }
}

class _PostsRowWidget extends StatelessWidget {
  final int index;
  const _PostsRowWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final post =
        HttpRequestExampleModelProvider.read(context)!.model.posts[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(post.id.toString()),
        const SizedBox(height: 10),
        Text(post.title),
        const SizedBox(height: 10),
        Text(post.body),
        const SizedBox(height: 40),
      ],
    );
  }
}
