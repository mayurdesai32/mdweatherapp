import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mdweatherapp/hourly_forecast.dart';
import 'package:mdweatherapp/addition_info.dart';
import 'package:mdweatherapp/secrets.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String cityName = 'Mumbai';
      final res = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherApikey"));
      final data = jsonDecode(res.body);
      if (data['cod'] != '200') {
        throw 'an unexpected error occurred';
      }

      return data;
      // temp1 = data['list'][0]['main']['temp'];
    } catch (e) {
      // throw e.toString();
      throw 'an unexpected error occurred';
      // print(e);
    }
  }

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
                setState(() {});
              },
              icon: const Icon(Icons.refresh)),
          const SizedBox(width: 20),
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          final data = snapshot.data!;
          final currentWeatherData = data['list'][0];
          final currentHumidity = currentWeatherData['main']['humidity'];
          final currentTemp = currentWeatherData['main']['temp'];
          final currentsky = currentWeatherData['weather'][0]['main'];
          final currentPressure = currentWeatherData['main']['pressure'];
          final currentWindSpeed = currentWeatherData['wind']['speed'];
          // final currentHumidity = currentWeatherData['wind']['humidity'];

          return Padding(
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
                            child: Padding(
                              padding: EdgeInsets.only(top: 20, bottom: 20),
                              child: Column(children: [
                                Text(
                                  '$currentTemp k',
                                  // "200",
                                  style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  currentsky == 'Clouds' || currentsky == 'Rain'
                                      ? Icons.cloud
                                      : Icons.sunny,
                                  size: 64,
                                ),
                                Text(
                                  currentsky,
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

                  const Text("Weatherly Forecast",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 20,
                  ),
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     children: [
                  //       for (int i = 0; i < 5; i++)
                  //         HourlyForecast(
                  //             time: data['list'][i + 1]['dt'].toString(),
                  //             temp: data['list'][i + 1]['main']['temp']
                  //                 .toString(),
                  //             icon: data['list'][i + 1]['weather'][0]['main'] ==
                  //                         'Clouds' ||
                  //                     data['list'][i + 1]['weather'][0]
                  //                             ['main'] ==
                  //                         'Rain'
                  //                 ? Icons.cloud
                  //                 : Icons.sunny),
                  //     ],
                  //   ),
                  // )
                  // addition info
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                        itemCount: data['list'].length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: ((context, index) {
                          // print('*******************************');
                          // print(index);

                          // print('*******************************');

                          return HourlyForecast(
                              time:
                                  // data['list'][index + 1]['dt_txt'].toString(),
                                  DateFormat('j').format(DateTime.parse(
                                      data['list'][index + 1]['dt_txt']
                                          .toString())),
                              temp: data['list'][index + 1]['main']['temp']
                                  .toString(),
                              icon: data['list'][index + 1]['weather'][0]
                                              ['main'] ==
                                          'Clouds' ||
                                      data['list'][index + 1]['weather'][0]
                                              ['main'] ==
                                          'Rain'
                                  ? Icons.cloud
                                  : Icons.sunny);
                        })),
                  ),
                  const SizedBox(
                    height: 35,
                  ),

                  const Text("Addition Information",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AdditionInfo(
                          icon: Icons.water_drop,
                          label: "Humidity",
                          value: currentHumidity.toString()),
                      AdditionInfo(
                          icon: Icons.air,
                          label: "Wind Speed",
                          value: currentWindSpeed.toString()),
                      AdditionInfo(
                          icon: Icons.beach_access,
                          label: "Pressure",
                          value: currentPressure.toString())
                    ],
                  ),
                ]),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
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
