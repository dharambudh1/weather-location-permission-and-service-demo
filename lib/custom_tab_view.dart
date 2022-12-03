import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather/weather.dart';

class CustomTabView extends StatelessWidget {
  final Placemark placeMark;
  final Weather weather;
  const CustomTabView({
    Key? key,
    required this.placeMark,
    required this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Column(
        children: [
          TabBar(
            indicatorColor: Theme.of(context).buttonTheme.colorScheme?.primary,
            physics: const ScrollPhysics(),
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.location_history,
                  color: Theme.of(context).buttonTheme.colorScheme?.primary,
                ),
                child: Text(
                  'Geographical',
                  style: TextStyle(
                    color: Theme.of(context).buttonTheme.colorScheme?.primary,
                  ),
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.cloudy_snowing,
                  color: Theme.of(context).buttonTheme.colorScheme?.primary,
                ),
                child: Text(
                  'Weather',
                  style: TextStyle(
                    color: Theme.of(context).buttonTheme.colorScheme?.primary,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              physics: const ScrollPhysics(),
              children: <Widget>[
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('name: ${placeMark.name}'),
                        const SizedBox(height: 8.0),
                        Text('street: ${placeMark.street}'),
                        const SizedBox(height: 8.0),
                        Text('isoCountryCode: ${placeMark.isoCountryCode}'),
                        const SizedBox(height: 8.0),
                        Text('country: ${placeMark.country}'),
                        const SizedBox(height: 8.0),
                        Text('postalCode: ${placeMark.postalCode}'),
                        const SizedBox(height: 8.0),
                        Text(
                            'administrativeArea: ${placeMark.administrativeArea}'),
                        const SizedBox(height: 8.0),
                        Text(
                            'subAdministrativeArea: ${placeMark.subAdministrativeArea}'),
                        const SizedBox(height: 8.0),
                        Text('locality: ${placeMark.locality}'),
                        const SizedBox(height: 8.0),
                        Text('subLocality: ${placeMark.subLocality}'),
                        const SizedBox(height: 8.0),
                        Text('thoroughfare: ${placeMark.thoroughfare}'),
                        const SizedBox(height: 8.0),
                        Text('subThoroughfare: ${placeMark.subThoroughfare}'),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('date: ${weather.date}'),
                        const SizedBox(height: 8.0),
                        Text('latitude: ${weather.latitude}'),
                        const SizedBox(height: 8.0),
                        Text('longitude: ${weather.longitude}'),
                        const SizedBox(height: 8.0),
                        Text('areaName: ${weather.areaName}'),
                        const SizedBox(height: 8.0),
                        Text('country: ${weather.country}'),
                        const SizedBox(height: 8.0),
                        Text('cloudiness: ${weather.cloudiness}'),
                        const SizedBox(height: 8.0),
                        Text('pressure: ${weather.pressure}'),
                        const SizedBox(height: 8.0),
                        Text('humidity: ${weather.humidity}'),
                        const SizedBox(height: 8.0),
                        Text('weatherIcon: ${weather.weatherIcon}'),
                        const SizedBox(height: 8.0),
                        Text(
                            'weatherConditionCode: ${weather.weatherConditionCode}'),
                        const SizedBox(height: 8.0),
                        Text('weatherMain: ${weather.weatherMain}'),
                        const SizedBox(height: 8.0),
                        Text(
                            'weatherDescription: ${weather.weatherDescription}'),
                        const SizedBox(height: 8.0),
                        Text('sunrise: ${weather.sunrise}'),
                        const SizedBox(height: 8.0),
                        Text('sunset: ${weather.sunset}'),
                        const SizedBox(height: 8.0),
                        Text('rainLastHour: ${weather.rainLastHour}'),
                        const SizedBox(height: 8.0),
                        Text('rainLast3Hours: ${weather.rainLast3Hours}'),
                        const SizedBox(height: 8.0),
                        Text('snowLastHour: ${weather.snowLastHour}'),
                        const SizedBox(height: 8.0),
                        Text('snowLast3Hours: ${weather.snowLast3Hours}'),
                        const SizedBox(height: 8.0),
                        Text('temperature: ${weather.temperature}'),
                        const SizedBox(height: 8.0),
                        Text('tempFeelsLike: ${weather.tempFeelsLike}'),
                        const SizedBox(height: 8.0),
                        Text('tempMin: ${weather.tempMin}'),
                        const SizedBox(height: 8.0),
                        Text('tempMax: ${weather.tempMax}'),
                        const SizedBox(height: 8.0),
                        Text('windDegree: ${weather.windDegree}'),
                        const SizedBox(height: 8.0),
                        Text('windSpeed: ${weather.windSpeed}'),
                        const SizedBox(height: 8.0),
                        Text('windGust: ${weather.windGust}'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
