import 'dart:convert';
import 'package:http/http.dart' as http;

const appVersion = '1.0.0';
const appStatusUrl = 'https://nvd1rmh.github.io/FCoin/app-status.json';

class AppStatus {
  final bool enabled;
  final String minimumVersion;
  final String message;

  const AppStatus({required this.enabled, required this.minimumVersion, required this.message});

  bool get isCurrentVersionAllowed => enabled && _compareVersions(appVersion, minimumVersion) >= 0;

  static Future<AppStatus> fetch() async {
    final uri = Uri.parse(appStatusUrl).replace(queryParameters: {'v': DateTime.now().millisecondsSinceEpoch.toString()});
    final response = await http.get(uri, headers: const {
      'Cache-Control': 'no-cache, no-store, must-revalidate',
      'Pragma': 'no-cache',
    }).timeout(const Duration(seconds: 12));
    if (response.statusCode != 200) {
      throw const FormatException('وضعیت برنامه از سرور دریافت نشد.');
    }
    final data = jsonDecode(utf8.decode(response.bodyBytes));
    if (data is! Map<String, dynamic> || data['minimumVersion'] is! String) {
      throw const FormatException('فایل وضعیت برنامه معتبر نیست.');
    }
    final minVersion = (data['minimumVersion'] as String).trim();
    if (minVersion.isEmpty) throw const FormatException('نسخهٔ مجاز در فایل وضعیت مشخص نشده است.');
    return AppStatus(
      enabled: data['enabled'] != false,
      minimumVersion: minVersion,
      message: data['message'] is String ? data['message'] as String : 'این نسخه قدیمی شده است. نسخهٔ جدید را از کانال تلگرام @FarnoElectronic نصب کنید.',
    );
  }
}

int _compareVersions(String left, String right) {
  List<int> parts(String value) => value.split('+').first.split('.').map((part) => int.tryParse(part) ?? 0).toList();
  final a = parts(left);
  final b = parts(right);
  for (var i = 0; i < (a.length > b.length ? a.length : b.length); i++) {
    final x = i < a.length ? a[i] : 0;
    final y = i < b.length ? b[i] : 0;
    if (x != y) return x.compareTo(y);
  }
  return 0;
}
