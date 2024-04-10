import 'package:flutter/material.dart';
import 'package:client.gogogo/locale/locales.dart';
import 'package:client.gogogo/presentation/routes/routes.dart';
import 'package:client.gogogo/presentation/themes/colors.dart';

class DeliveryCard extends StatelessWidget {
  const DeliveryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, PageRoutes.truckAndTripInfo);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: lightBgColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              ),
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.asset(
                      "assets/truck2.jpg",
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    "GTY 1024",
                    style: theme.textTheme.headlineSmall!.copyWith(
                      color: blackTextColor,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text('SCANIA R730', style: theme.textTheme.bodySmall),
                  const Spacer(),
                  Text(
                    context.getTranslationOf('in_transit')!,
                    style: theme.textTheme.titleLarge!.copyWith(
                      color: lightGreenTextColor,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                Text(context.getTranslationOf('task')!,
                    style: theme.textTheme.bodySmall),
                const Spacer(),
                Text(context.getTranslationOf('departed')!,
                    style: theme.textTheme.bodySmall),
                const Spacer(),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                Text(
                  context.getTranslationOf('chemical_Delivery')!,
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.normal,
                    color: blackTextColor,
                  ),
                ),
                const Spacer(),
                Text(
                  "20 June, 02:05pm",
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.normal,
                    color: blackTextColor,
                  ),
                ),
                const Spacer(),
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
            ListTile(
              title: Text(context.getTranslationOf('current_location')!,
                  style: theme.textTheme.bodySmall),
              subtitle: Text(
                "1141, Hemilton Tower, New York, USA",
                style: theme.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.normal,
                  color: blackTextColor,
                ),
              ),
              trailing: Container(
                decoration: BoxDecoration(
                    color: theme.colorScheme.background,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(spreadRadius: 1, color: lightBgColor)
                    ]),
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.map,
                  color: theme.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
