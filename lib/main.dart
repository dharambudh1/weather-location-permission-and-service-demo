import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:geocoding/geocoding.dart';
import 'package:location_with_permission/custom_tab_view.dart';
import 'package:location_with_permission/location_service.dart';
import 'package:weather/weather.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final WeatherFactory weatherFactory = WeatherFactory(
    "856822fd8e22db5e1ba48c0e7d69844a",
  );

  geolocator.Position? position;
  List<Placemark>? listPlaceMark;
  Placemark? placeMark;
  Weather? weather;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: geolocationPosition,
        child: const Icon(Icons.my_location),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: Text(
                "In iOS, the location prompt will only ask once. If you don't allow then the app will not work anymore. You may need to re-install the app and press allow on the location permission. As well as, you can not see this app in the main settings app due to a lack of location capabilities. The location capabilities feature requires the Apple developer account with membership purchased.",
              ),
            ),
            const SizedBox(height: 16.0),
            placeMark == null && weather == null
                ? const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: Text(
                      'Tap on location icon to fetch Geographical & Weather information',
                    ),
                  )
                : Expanded(
                    child: CustomTabView(
                      placeMark: placeMark ?? Placemark(),
                      weather: weather ?? Weather({}),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Future<geolocator.Position> geolocationPosition() async {
    position = await LocationService.determinePosition(
      context: context,
      mounted: mounted,
    );
    listPlaceMark = await placemarkFromCoordinates(
      position?.latitude ?? 0,
      position?.longitude ?? 0,
    );
    placeMark = listPlaceMark?.first ?? Placemark();
    weather = await currentWeatherByLocation(
      position?.latitude ?? 0,
      position?.longitude ?? 0,
    );
    setState(() {});
    return Future.value(position);
  }

  Future<Weather> currentWeatherByLocation(
    double latitude,
    double longitude,
  ) async {
    Weather w = await weatherFactory.currentWeatherByLocation(
      latitude,
      longitude,
    );
    return Future.value(w);
  }
}
