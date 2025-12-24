import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvHandler {
  EnvHandler._();

  static String google_map_api_key = dotenv.env['GOOGLE_MAPS_API_KEY']!;

// EnvHandler({required this.googleMapApiKey});

// static EnvHandler load() {
//   _instance ??= EnvHandler(
//     googleMapApiKey: dotenv.env['GOOGLE_MAPS_API_KEY']!,
//   );

//   return _instance!;
// }
}