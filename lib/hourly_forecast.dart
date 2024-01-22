import 'package:flutter/material.dart';

class HourlyForecast extends StatelessWidget {
  final String time;
  final String temp;
  final IconData icon;
  const HourlyForecast(
      {required this.time, required this.temp, required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        elevation: 6,
        child: Container(
          width: 100,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          padding: EdgeInsets.all(8.0),
          child: Column(children: [
            Text(
              // time.substring(11, 16),
              time,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            const SizedBox(
              height: 8,
            ),
            Icon(
              icon,
              size: 32,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              temp + 'K',
              style: TextStyle(
                  // fontSize: 15,
                  ),
            ),
          ]),
        ),
      ),
    );
  }
}
