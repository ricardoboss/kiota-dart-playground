import 'dart:async';

import 'package:kiota_dart_playground/kiota_dart_playground.dart' as lib;

Future<void> main(List<String> arguments) async {
  final startupHandle = Completer.sync();
  final closeHandle = Completer.sync();
  final server = lib.runServer(
    startupHandle,
    closeHandle.future,
    lib.generateResponse,
  );

  try {
    await startupHandle.future;

    await lib.runClient();
  } finally {
    closeHandle.complete();

    await server;
  }
}
