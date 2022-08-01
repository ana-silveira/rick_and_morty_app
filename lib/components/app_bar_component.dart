import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rick_and_morty_app/pages/home_page.dart';
import 'package:rick_and_morty_app/theme/app_colors.dart';
import 'package:rick_and_morty_app/theme/app_images.dart';

PreferredSizeWidget appBarComponent(
  BuildContext context, {
  bool isSecondPage = false,
}) {
  return AppBar(
      toolbarHeight: kToolbarHeight * 2.3,
      backgroundColor: AppColors.appBarColor,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      leading: Align(
        alignment: Alignment.topCenter,
        child: GestureDetector(
          onTap: () {
            final currentRoute = ModalRoute.of(context)?.settings.name;
            if (currentRoute == HomePage.routeId) return;
            Navigator.of(context).pop();
          },
          child: Icon(
            color: AppColors.black,
            isSecondPage ? Icons.arrow_back : Icons.menu,
          ),
        ),
      ),
      actions: [
        Container(
          alignment: Alignment.topCenter,
          margin: const EdgeInsets.only(right: 16, top: 1),
          child: const Icon(
            Icons.person,
            color: AppColors.black,
          ),
        )
      ],
      flexibleSpace: SafeArea(
          child: Column(children: [
        Image.asset(
          AppImages.logo,
          fit: BoxFit.contain,
          height: 95,
        ),
        const Padding(
            padding: EdgeInsets.only(top: 1.0),
            child: Text("RICK AND MORTY API",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  color: AppColors.black,
                )))
      ])));
}
