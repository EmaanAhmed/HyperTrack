import 'package:flutter/material.dart';
import 'package:hypertrack_plugin/hypertrack.dart';
import 'package:quickstartflutter/networking.dart';
import 'package:url_launcher/url_launcher.dart';

const String publishableKey =
    'KMDnhOzvI2W_ER_Qwiky9tE0E544YncXBUYOYj1JZ0nSaSSiHbXUjPAQEOOrj1tSi81JZoB7xjWDOq9unAz0-g';
void main() => runApp(HyperTrackQuickStart());

class HyperTrackQuickStart extends StatefulWidget {
  HyperTrackQuickStart({Key key}) : super(key: key);

  @override
  _HyperTrackQuickStartState createState() => _HyperTrackQuickStartState();
}

class _HyperTrackQuickStartState extends State<HyperTrackQuickStart> {
  HyperTrack sdk;
  String deviceId;
  NetworkHelper helper;
  String result = '';
  bool isLink = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initializeSdk();
  }

  Future<void> initializeSdk() async {
    sdk = await HyperTrack.initialize(publishableKey);
    deviceId = await sdk.getDeviceId();
    sdk.setDeviceName('Eman');
    helper = NetworkHelper(
      url: 'https://v3.api.hypertrack.com',
      auth:
          'Basic WjZFOVh2aWl4RlRRZFdkX1lLVk56Ykl3U3h3Oi1NRVItQ081aHUzMG5aNHc0YnBhWjRzUW9RUWRmaUJPNkhuYklYcF9sd19wYUtvT1NuRjhDUQ==',
      id: deviceId,
    );
    print(deviceId);
  }

  void shareLink() async {
    setState(() {
      isLoading = true;
      result = '';
    });
    var data = await helper.getData();
    setState(() {
      result = data['views']['share_url'];
      isLink = true;
      isLoading = false;
    });
  }

  void startTracking() async {
    setState(() {
      isLoading = true;
      result = '';
    });
    var startTrack = await helper.startTracing();
    setState(() {
      result = (startTrack['message']);
      isLink = false;
      isLoading = false;
    });
  }

  void endTracking() async {
    setState(() {
      isLoading = true;
      result = '';
    });
    var endTrack = await helper.endTracing();
    setState(() {
      result = (endTrack['message']);
      isLink = false;
      isLoading = false;
    });
  }

  void lunchUrl() async {
    await launch(result);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 0.0,
            width: double.infinity,
          ),
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isLoading ? CircularProgressIndicator() : Text(''),
                SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                  child: Text(
                    result,
                    style: TextStyle(
                        color: isLink ? Colors.blue[900] : Colors.red[900],
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: isLink ? lunchUrl : null,
                ),
              ],
            ),
          ),
          FlatButton(
            child: Text(
              'Strat Tracking my Location',
            ),
            onPressed: startTracking,
          ),
          FlatButton(
            child: Text('get my Location Link'),
            onPressed: shareLink,
          ),
          FlatButton(
            child: Text('End Tracking my Location'),
            onPressed: endTracking,
          ),
        ],
      ),
    ));
  }
}
