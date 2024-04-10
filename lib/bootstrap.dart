import 'dart:async';
import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/observers/riverpod_observer.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    //Aqui podemos usar telecatcher
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  runApp(
    ProviderScope(
      observers: [
        Logger(),
      ],
      child: await builder(),
    ),
  );

  // await runZonedGuarded(
  //   () async => runApp(
  //     ProviderScope(
  //       observers: [
  //         Logger(),
  //       ],
  //       child: await builder(),
  //     ),
  //   ),
  //   (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  // );
}
