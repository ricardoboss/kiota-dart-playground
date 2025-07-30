import 'package:kiota_dart_playground/generated/api_client.dart';
import 'package:microsoft_kiota_bundle/microsoft_kiota_bundle.dart';

Future<void> runClient() async {
  print("Running Client");

  final authProvider = AnonymousAuthenticationProvider();
  final adapter = DefaultRequestAdapter(authProvider: authProvider)
    ..baseUrl = "http://localhost:4183";
  final apiClient = ApiClient(adapter);

  final response = await apiClient.workouts.getAsync();

  print(response!.workoutDates!.single);
}

Future<Map<String, dynamic>> generateResponse() async {
  return {
    "workout_dates": ["2025-07-30T23:39:48.101Z"],
  };
}
