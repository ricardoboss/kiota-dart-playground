import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data' show BytesBuilder;

Future<void> runServer(
  Completer startupHandle,
  Future<void> closeHandle,
  Future<Map<String, dynamic>> Function() responseFactory,
) async {
  print("Running Server on port 4183");

  var server = await HttpServer.bind(InternetAddress.anyIPv4, 4183);

  closeHandle.then((_) {
    print("Server closing");

    return server.close();
  });

  startupHandle.complete();

  await server.forEach((HttpRequest request) async {
    print("=== Incoming request:");
    print('HTTP ${request.method} ${request.uri.path}');
    request.headers.forEach((key, value) {
      print('$key: ${value.join(', ')}');
    });
    print('');
    final byteChunks = await request.toList();
    final body = utf8.decode(
      byteChunks
          .fold(BytesBuilder(copy: false), (b, c) => b..add(c))
          .takeBytes(),
    );
    print(body);
    print('===');

    var responseObj = await responseFactory();
    request.response.headers.contentType = ContentType.json;
    request.response.write(json.encode(responseObj));
    request.response.close();
  });

  print("Server closed");
}
