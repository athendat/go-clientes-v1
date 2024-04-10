import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserRouterPage extends ConsumerWidget {
  const UserRouterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //ref.watch(electronicSignatureProvider);
    return const AutoRouter();
  }
}
