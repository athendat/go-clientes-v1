import '../locale/languages/english.dart';
import '../locale/languages/italian.dart';
import '../locale/languages/spanish.dart';

class AppConfig {
  static const String appName = 'Trucks Up';
  static const String packageName = 'com.flutter.trucks_up';
  static const String languageDefault = "en";
  static final Map<String, AppLanguage> languagesSupported = {
    'en': AppLanguage("English", english()),
    'es': AppLanguage("Español", spanish()),
    'it': AppLanguage("italiano", italian()),
  };
  static const bool isDemoMode = true;
}

class AppLanguage {
  final String name;
  final Map<String, String> values;
  AppLanguage(this.name, this.values);
}
