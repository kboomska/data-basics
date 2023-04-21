import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';

import 'package:http_requests/domain/entity/post.dart';

class ApiClient {
  final client = HttpClient();

  Future<List<Post>> getPosts() async {
    // Prepare the url where to request:
    // final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final url = Uri(
      scheme: 'https',
      host: 'jsonplaceholder.typicode.com',
      path: 'posts',
    );

    // Make a request and wait for an answer (response):
    final request = await client.getUrl(url);
    final response = await request.close();
    // print(response.statusCode); // 200 - it's OK.

    // List of bytes.
    // response.listen((event) {
    //   print(event);
    //   print(1);
    // });

    // Decode the bytes to strings.
    // response.transform(utf8.decoder).listen((event) {
    //   print(event);
    //   print('End of the piece of data');
    // });

    // Returns the List of Strings when the Stream closes:
    final jsonStrings = await response.transform(utf8.decoder).toList();

    // From List of Strings to a String:
    final jsonString = jsonStrings.join();

    // Decode the String as JSON:
    final json = jsonDecode(jsonString) as List<dynamic>;

    // Get JSON with our helper function get():
    final newJson = await get('https://jsonplaceholder.typicode.com/posts')
        as List<dynamic>;

    // Mapping the JSON to out Post data:
    final posts = newJson
        .map(
          (e) => Post.fromJson(e as Map<String, dynamic>),
        )
        .toList();
    return posts;
  }

  Future<dynamic> get(String uri) async {
    final url = Uri.parse(uri);

    final request = await client.getUrl(url);
    final response = await request.close();

    final json = await response
        .transform(utf8.decoder)
        .toList()
        .then((jsonStrings) => jsonStrings.join())
        .then((jsonString) => jsonDecode(jsonString));

    return json;
  }

  Future<Post> createPost({
    required String title,
    required String body,
  }) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final parameters = <String, dynamic>{
      'title': title,
      'body': body,
      'userId': 109,
    };

    final request = await client.postUrl(url);
    request.headers.set('Content-type', 'application/json; charset=UTF-8');
    // Encode Map to JSON and write it to request.
    request.write(jsonEncode(parameters));
    final response = await request.close();

    final json = await response
        .transform(utf8.decoder)
        .toList()
        .then((jsonStrings) => jsonStrings.join())
        .then((jsonString) => jsonDecode(jsonString) as Map<String, dynamic>);

    final post = Post.fromJson(json);

    return post;
  }

  // Upload file example (don't work now!)
  Future<void> fileUpload(File file) async {
    final url = Uri.parse('https://example.com');

    final request = await client.postUrl(url);

    request.headers.set(HttpHeaders.contentTypeHeader, ContentType.binary);
    request.headers.add('filename', basename(file.path));
    request.contentLength = file.lengthSync();
    final fileStream = file.openRead();
    await request.addStream(fileStream);

    final httpResponse = await request.close();

    if (httpResponse.statusCode != 200) {
      throw Exception('Error uploading file');
    } else {
      return;
    }
  }
}
