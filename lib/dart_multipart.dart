import 'package:dart_multipart/generated/api_client.dart';
import 'package:microsoft_kiota_abstractions/microsoft_kiota_abstractions.dart';
import 'package:microsoft_kiota_bundle/microsoft_kiota_bundle.dart';

Future<void> run() async {
  print("Running");

  final authProvider = AnonymousAuthenticationProvider();
  final adapter = DefaultRequestAdapter(authProvider: authProvider);
  final apiClient = ApiClient(adapter);

  final body = MultipartBody();

  final response = await apiClient.upload.postAsync(body);

  print(response);
}
