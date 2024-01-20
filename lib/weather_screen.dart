import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mdweatherapp/hourly_forecast.dart';
import 'package:mdweatherapp/addition_info.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "MDWeather App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                debugPrint("refresh");
              },
              icon: const Icon(Icons.refresh)),
          const SizedBox(width: 20),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                    elevation: 20,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: const Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          child: Column(children: [
                            Text(
                              '300K',
                              style: TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.cloud,
                              size: 64,
                            ),
                            Text(
                              "Rain",
                              style: TextStyle(fontSize: 20),
                            )
                          ]),
                        ),
                      ),
                    )),
              ),

              const SizedBox(
                height: 35,
              ),
              // weather forecast card

              const Text("Weather Forecast",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    HourlyForecast(
                        time: "10:00", temp: "201.2", icon: Icons.cloud),
                    HourlyForecast(
                        time: "10:00", temp: "201.2", icon: Icons.cloud),
                    HourlyForecast(
                        time: "10:00", temp: "201.2", icon: Icons.cloud),
                    HourlyForecast(
                        time: "10:00", temp: "201.2", icon: Icons.cloud),
                    HourlyForecast(
                        time: "10:00", temp: "201.2", icon: Icons.cloud),
                    HourlyForecast(
                        time: "10:00", temp: "201.2", icon: Icons.cloud),
                    HourlyForecast(
                        time: "10:00", temp: "201.2", icon: Icons.cloud),
                    HourlyForecast(
                        time: "10:00", temp: "201.2", icon: Icons.cloud),
                    HourlyForecast(
                        time: "10:00", temp: "201.2", icon: Icons.cloud)
                  ],
                ),
              )
              // addition info
              ,
              const SizedBox(
                height: 35,
              ),

              const Text("Addition Information",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AdditionInfo(
                      icon: Icons.water_drop, label: "Humidity", value: '95'),
                  AdditionInfo(
                      icon: Icons.air, label: "Wind Speed", value: '7.5'),
                  AdditionInfo(
                      icon: Icons.beach_access, label: "Pressure", value: '950')
                ],
              ),
            ]),
      ),
      bottomNavigationBar: BottomAppBar(
        surfaceTintColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              "Made by me @ Mayur Desai",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );

    // BottomNavigationBar:BottomAppBar(child: Text("mayur desai"));
  }
}
