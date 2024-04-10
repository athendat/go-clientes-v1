import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:client.gogogo/locale/locales.dart';
import 'package:client.gogogo/presentation/routes/routes.dart';
import 'package:client.gogogo/presentation/themes/colors.dart';

class DriversList extends StatelessWidget {
  const DriversList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return FadedSlideAnimation(
      beginOffset: const Offset(0.3, 0.3),
      endOffset: const Offset(0, 0),
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, PageRoutes.driverInfo);
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.background,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/Profile pic.png",
                      scale: 5,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Peter Williamson",
                          style: theme.textTheme.bodyLarge!.copyWith(
                            color: blackTextColor,
                          ),
                        ),
                        Text(
                          "+ 1 987 654 3210",
                          style: theme.textTheme.bodySmall,
                        )
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.getTranslationOf('in_transit')!,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: lightGreenTextColor,
                            fontSize: 16,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                              text:
                                  "${context.getTranslationOf('in_truck_num')!}  ",
                              style: theme.textTheme.bodySmall,
                              children: [
                                TextSpan(
                                    text: "GTY 1024",
                                    style: theme.textTheme.bodyMedium!.copyWith(
                                      color: blackTextColor,
                                      fontSize: 12,
                                    )),
                              ]),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                  ],
                ),
              ),
            );
          }),
      // curve: Curves.easeInCubic,
    );
  }
}
