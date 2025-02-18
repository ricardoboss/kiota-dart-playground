import 'dart:async';

import 'package:dart_multipart/dart_multipart.dart' as dart_multipart;

Future<void> main(List<String> arguments) async {
  final startupHandle = Completer.sync();
  final closeHandle = Completer.sync();
  final server = dart_multipart.runServer(startupHandle, closeHandle.future);

  try {
    await startupHandle.future;

    await dart_multipart.runClient();
  } finally {
    closeHandle.complete();

    await server;
  }
}
