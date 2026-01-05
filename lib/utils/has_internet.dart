
import 'package:connectivity_plus/connectivity_plus.dart';
import '../core/common_widgets/custom_toast.dart';

Future<bool> hasInternet({bool showError = false}) async {
  final List<ConnectivityResult> connectivityResult =
  await (Connectivity().checkConnectivity());
  if (connectivityResult.contains(ConnectivityResult.none)) {
    if (showError) {
      showCustomToast(
        text:
        'Failed to establish connection, please check your internet connection',
      );
    }

    return false;
  } else {
    return true;
  }
}
