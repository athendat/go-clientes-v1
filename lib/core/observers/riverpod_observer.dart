import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<dynamic> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    log(
      '''
{
  "Provider": "${provider.name ?? provider.runtimeType}",
  "Previous value": "$previousValue",
  "New Value": "$newValue"
}''',
      name: 'RiverpodState',
    );
//     // print('''
// {
//   "provider": "${provider.name ?? provider.runtimeType}",
//   "newValue": "$newValue"
// }''');
  }
}
