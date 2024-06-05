import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({Key? key}) : super(key: key);

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  late final WeatherFactory _wf;
  Weather? _currentWeather;
  List<Weather>? _forecast;
  List<String> _locations = ['Dhaka', 'New York', 'London'];
  String _selectedLocation = 'Dhaka';
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  String _aqi = '';

  @override
  void initState() {
    super.initState();
    _wf = WeatherFactory('0006cfc2b3e0a12c46a2c815a76d3fb0');
    _initializeNotifications();
    _fetchWeather();
    _fetchAQI();
  }

  Future<void> _fetchWeather() async {
    Weather currentWeather = await _wf.currentWeatherByCityName(_selectedLocation);
    List<Weather> forecast = await _wf.fiveDayForecastByCityName(_selectedLocation);

    setState(() {
      _currentWeather = currentWeather;
      _forecast = forecast;
    });

    _checkForSevereWeather(currentWeather);
  }

  Future<void> _fetchAQI() async {
    // Mocked AQI fetching function, replace with actual API call
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _aqi = 'AQI: 42 (Good)';
    });
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your channel id', 'your channel name', channelDescription: 'your channel description',
            importance: Importance.max, priority: Priority.high, ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(0, title, body, platformChannelSpecifics, payload: 'item x');
  }

  void _checkForSevereWeather(Weather weather) {
    if (weather.weatherDescription!.contains('storm') || weather.weatherDescription!.contains('tornado')) {
      _showNotification('Severe Weather Alert', 'A severe weather alert is in effect for $_selectedLocation.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    if (_currentWeather == null || _forecast == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          _locationSelector(),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.red,
              alignment: Alignment.center,
              child: _locationHeader(),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.blue,
              alignment: Alignment.center,
              child: _currentTemp(),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.green,
              alignment: Alignment.center,
              child: _weatherIcon(),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.purple,
              alignment: Alignment.center,
              child: _aqiInfo(),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.orange,
              child: Column(
                children: [
                  _extraInfo(),
                  _forecastList(),
                  _weatherMap(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _locationSelector() {
    return DropdownButton<String>(
      value: _selectedLocation,
      items: _locations.map((String location) {
        return DropdownMenuItem<String>(
          value: location,
          child: Text(location),
        );
      }).toList(),
      onChanged: (newLocation) {
        setState(() {
          _selectedLocation = newLocation!;
        });
        _fetchWeather();
        _fetchAQI();
      },
    );
  }

  Widget _locationHeader() {
    return Text(
      _currentWeather!.areaName!,
      style: TextStyle(
        color: Colors.white,
        fontSize: 24.0,
      ),
    );
  }

  Widget _currentTemp() {
    return Text(
      '${_currentWeather!.temperature!.celsius!.toStringAsFixed(1)}°C',
      style: TextStyle(
        color: Colors.white,
        fontSize: 24.0,
      ),
    );
  }

  Widget _weatherIcon() {
    return _currentWeather!.weatherIcon != null
        ? Image.network('http://openweathermap.org/img/w/${_currentWeather!.weatherIcon}.png')
        : Container();
  }

  Widget _aqiInfo() {
    return Text(
      _aqi,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
      ),
    );
  }

  Widget _extraInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Humidity: ${_currentWeather!.humidity}%',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        Text(
          'Wind Speed: ${_currentWeather!.windSpeed} m/s',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }

  Widget _forecastList() {
    return Expanded(
      child: ListView.builder(
        itemCount: _forecast!.length,
        itemBuilder: (context, index) {
          Weather weather = _forecast![index];
          return ListTile(
            leading: weather.weatherIcon != null
                ? Image.network('http://openweathermap.org/img/w/${weather.weatherIcon}.png')
                : Container(),
            title: Text(
              '${weather.temperature!.celsius!.toStringAsFixed(1)}°C',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              weather.date!.toString(),
              style: TextStyle(color: Colors.white70),
            ),
          );
        },
      ),
    );
  }

  Widget _weatherMap() {
    return Expanded(
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(23.8103, 90.4125), // Centered on Dhaka, change dynamically for each location
          zoom: 10,
        ),
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {},
      ),
    );
  }
}
