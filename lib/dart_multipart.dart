import 'dart:async';
import 'dart:io';

import 'package:dart_multipart/generated/api_client.dart';
import 'package:microsoft_kiota_abstractions/microsoft_kiota_abstractions.dart';
import 'package:microsoft_kiota_bundle/microsoft_kiota_bundle.dart';

Future<void> runClient() async {
  print("Running Client");

  final authProvider = AnonymousAuthenticationProvider();
  final adapter = DefaultRequestAdapter(authProvider: authProvider);
  final apiClient = ApiClient(adapter);

  final body = MultipartBody();
  body.addOrReplace("userId", "application/json", "123");

  final response = await apiClient.upload.postAsync(body);

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

  await server.forEach((HttpRequest request) {
    request.response.write('ok');
    request.response.close();
  });

  print("Server closed");
}
