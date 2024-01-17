import 'dart:developer';

import 'package:assignment/app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (_) {
      return RefreshIndicator(
        onRefresh: () {
          return controller.getCurrentPosition();
        },
        child: Scaffold(
            appBar: AppBar(
                leading: Image.asset(
                  'assets/images/stemm_one_logo.jpg',
                ),
                title: Text(
                  'Weather Forecast',
                  style: GoogleFonts.roboto(
                      color: primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        showBottomDialog();
                      },
                      icon: const Icon(
                        Icons.favorite_border,
                        color: black,
                      )),
                  PopupMenuButton<String>(
                    onSelected: controller.handleClick,
                    itemBuilder: (BuildContext context) {
                      return {'Logout', 'Settings'}.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  ),
                ],
                centerTitle: false,
                bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(50),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: TextFormField(
                        controller: controller.searchController,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            hintText: "Search Location",
                            border: InputBorder.none,
                            hintStyle:
                                GoogleFonts.roboto(fontSize: 14, color: grey),
                            suffix: TextButton(
                              style:
                                  TextButton.styleFrom(backgroundColor: black),
                              child: Text("Search",
                                  style: GoogleFonts.roboto(
                                      color: white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              onPressed: () {
                                controller.getWeatherForecastApi(
                                    controller.searchController.text);
                              },
                            )),
                        textAlignVertical: TextAlignVertical.center,
                        textAlign: TextAlign.start,
                      ),
                    ))),
            body: controller.responseWeatherModel == null
                ? Center(
                    child: Text(
                    "No Weather Data Found",
                    style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: black),
                  ))
                : ListView(
                    shrinkWrap: true,
                    children: [
                      searchLocationView(),
                      currentWeatherView(),
                      foreCastView()
                    ],
                  )),
      );
    });
  }

  Widget searchLocationView() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
      child: Container(
        decoration: const BoxDecoration(color: orangeText),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Date : ${"${controller.responseWeatherModel!.location!.localtime}".split(" ").first}",
                style: GoogleFonts.roboto(color: white, fontSize: 14),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Current Location : ${controller.responseWeatherModel!.location!.name}, ${controller.responseWeatherModel!.location!.region}, ${controller.responseWeatherModel!.location!.country}",
                style: GoogleFonts.roboto(color: white, fontSize: 14),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton.icon(
                onPressed: () {
                  controller.markedFavorite == false
                      ? controller.onTapFavoriteButton(
                          "${controller.responseWeatherModel!.location!.name}, ${controller.responseWeatherModel!.location!.region}, ${controller.responseWeatherModel!.location!.country}")
                      : log("Already marked as favorite");
                },
                style: TextButton.styleFrom(backgroundColor: white),
                label: Text(
                  controller.markedFavorite == false
                      ? "Mark as Favorite"
                      : "Marked as Favorite",
                  style: GoogleFonts.roboto(color: orangeText, fontSize: 14),
                ),
                icon: Icon(
                  controller.markedFavorite == false
                      ? Icons.favorite_border
                      : Icons.favorite,
                  color: orangeText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget currentWeatherView() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
      child: Container(
        decoration: const BoxDecoration(color: blue),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: controller.onTapDegree == false
                    ? InkWell(
                        onTap: () {
                          controller.onTapDegreeTrue();
                        },
                        child: Text(
                          "${controller.responseWeatherModel!.current!.tempC}°",
                          style: GoogleFonts.roboto(color: white, fontSize: 70),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          controller.onTapDegreeFalse();
                        },
                        child: Text(
                          "${controller.responseWeatherModel!.current!.tempF}°F",
                          style: GoogleFonts.roboto(color: white, fontSize: 70),
                          textAlign: TextAlign.center,
                        ),
                      ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${controller.responseWeatherModel!.current!.condition!.text}",
                      style: GoogleFonts.roboto(color: white, fontSize: 20),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: const BoxDecoration(color: white),
                      child: Image.network(
                        "http:${controller.responseWeatherModel!.current!.condition!.icon}",
                        height: 50,
                        width: 50,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  "Wind : ${controller.responseWeatherModel!.current!.windKph}/Kph , Humidity : ${controller.responseWeatherModel!.current!.humidity}, UV : ${controller.responseWeatherModel!.current!.uv}",
                  style: GoogleFonts.roboto(color: white, fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget foreCastView() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
      child: Column(
        children: [
          Text(
            "7-day weather forecast",
            style: GoogleFonts.roboto(
                color: black, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: controller
                  .responseWeatherModel!.forecast!.forecastday!.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: const BoxDecoration(color: tertiary),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              controller.responseWeatherModel!.forecast!
                                  .forecastday![index].date
                                  .toString()
                                  .split(" ")
                                  .first,
                              style: GoogleFonts.roboto(
                                  color: black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              decoration: const BoxDecoration(color: white),
                              child: Image.network(
                                "http:${controller.responseWeatherModel!.forecast!.forecastday![index].day!.condition!.icon}",
                                height: 30,
                                width: 30,
                              ),
                            ),
                            Text(
                              "${controller.responseWeatherModel!.forecast!.forecastday![index].day!.mintempC}° / ${controller.responseWeatherModel!.forecast!.forecastday![index].day!.maxtempC}°",
                              style: GoogleFonts.roboto(
                                  color: black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }

  showBottomDialog() {
    Get.bottomSheet(InteractiveViewer(
      child: GetBuilder<HomeController>(builder: (_) {
        return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
                itemCount: controller.favorites.length,
                itemBuilder: (c, i) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () {
                        controller
                            .getWeatherForecastApi(controller.favorites[i]);
                        Get.back();
                        controller.searchController.clear();
                      },
                      child: Text(
                        controller.favorites[i],
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            color: black,
                            fontSize: 18),
                      ),
                    ),
                  );
                }));
      }),
    ), backgroundColor: white)
        .whenComplete(() {
      Get.back();
    });
  }
}
