import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/additional_information.dart';
import 'package:weatherapp/current_weather.dart';
import 'package:weatherapp/model/weather_api_client.dart';
import 'package:weatherapp/model/weather_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: HomePage()

    );
  }
}


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherApiClient client =  WeatherApiClient();
  Weather? data;
  Future<void> getData()async{
    data= await client.getCurrentWeather("Bangalore");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    client.getCurrentWeather("Bangalore");

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        title: Text("WEATHER APP",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
        ),
      ),

      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 60.0,

            ),




            currentWeather(Icons.wb_sunny_rounded, "26.3", "Bangalore"),
            Text(
              "Additional Information",
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),

            ),
            Divider(),
            SizedBox(
              height: 20.0,
            ),
            additionalInformation("4.88", "1015" , "84", "294.39",),
            FutureBuilder(
                future: apicall(),
                builder: (context,snapshot)
                {
                  if (snapshot.connectionState == ConnectionState.done)
                    return Column(
                      children: [

                        Text(snapshot.data['temp'].toString()),
                        Text(snapshot.data['description'].toString()),
                      ],
                    );

                  if (snapshot.hasData) {
                    return Text(snapshot.data['description']);
                  }
                  else if(snapshot.connectionState==ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else{
                    return Text("error");
                  }
                }
            ),



          ],
        ),
      ),

    );
  }
}

Future apicall() async {
  final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=bangalore&appid=0737c4fdaa11f09ad732a32769e0d3a6");
  final response = await http.get(url);
  print(response.statusCode);
  final json = jsonDecode(response.body);
  print(json['weather'][0]['description']);

  final output = {
    'description': json['weather'][0]['description'],
    'temp': json['main']['temp']
  };
  return output;
}