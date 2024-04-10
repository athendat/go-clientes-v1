import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthRouterPage extends ConsumerWidget {
  const AuthRouterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //ref.watch(electronicSignatureProvider);
    return const AutoRouter();
  }
}
