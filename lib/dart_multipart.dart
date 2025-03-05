import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dart_multipart/generated/api_client.dart';
import 'package:dart_multipart/generated/models/create_chat_completion_request.dart';
import 'package:dart_multipart/generated/models/create_chat_completion_request_model.dart';
import 'package:microsoft_kiota_bundle/microsoft_kiota_bundle.dart';

Future<void> runClient() async {
  print("Running Client");

  final authProvider = AnonymousAuthenticationProvider();
  final adapter = DefaultRequestAdapter(authProvider: authProvider);
  final apiClient = ApiClient(adapter);

  final model = CreateChatCompletionRequestModel()..string_ = "gpt-4o-latest";
  final body = CreateChatCompletionRequest()..model = model;
  final response = await apiClient.chat.completions.postAsync(body);

  print(response);
}

Future<void> runServer(
  Completer startupHandle,
  Future<void> closeHandle,
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

    request.response.write('ok');
    request.response.close();
  });

  print("Server closed");
}
