import 'package:kiota_dart_playground/generated/api_client.dart';
import 'package:microsoft_kiota_bundle/microsoft_kiota_bundle.dart';

Future<void> runClient() async {
  print("Running Client");

  final authProvider = AnonymousAuthenticationProvider();
  final adapter = DefaultRequestAdapter(authProvider: authProvider)
    // ..baseUrl = "http://localhost:4183"
  ;
  final apiClient = ApiClient(adapter);

  // final response = await apiClient.user.getAsync();
  //
  // print(response?.publicUser?.name);

  final response = await apiClient.packages.byPackage('agent_dart').versions.withVersionTarGz('123').getAsync();
  print(response);
}

Future<Map<String, dynamic>> generateResponse() async {
  return {
    "id": 12354564687654,
    "login": "some_user",
    "view_type": "private",
    "name": "Some User"
  };
}
