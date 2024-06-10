import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo/firebase/firebase_options.dart';
import 'package:firebase_demo/screen/home.dart';
import 'package:firebase_demo/screen/sign_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late StreamSubscription<List<ConnectivityResult>> _subscription;
  bool _isConnect = false;

  @override
  void initState() {
    super.initState();

    
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      _updateConnectionStatus(results);
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

 void _updateConnectionStatus(List<ConnectivityResult> results) {
    if (results.contains(ConnectivityResult.mobile)) {
      setState(() {
        _isConnect = true;
      });
    } else if (results.contains(ConnectivityResult.wifi)) {
      setState(() {
        _isConnect = true;
      });
    } else if (results.contains(ConnectivityResult.ethernet)) {
    } else if (results.contains(ConnectivityResult.vpn)) {
    } else if (results.contains(ConnectivityResult.bluetooth)) {
      // Bluetooth connection available.
    } else if (results.contains(ConnectivityResult.other)) {
    } else if (results.contains(ConnectivityResult.none)) {
      setState(() {
        _isConnect =false;
        print("Conection None");
      });
    }
  }


  // Future<void> _openNetworkSettings() async {
  //   final Uri url = Uri(scheme: 'app-settings');
  //   if (await canLaunchUrl(url)) {
  //     await launchUrl(url, mode: LaunchMode.externalApplication);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }


 Future<void> _openNetworkSettings() async {
    if (Platform.isAndroid) {
      final Uri uri = Uri.parse('network://');
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch $uri';
      }
    } else if (Platform.isIOS) {
      final Uri uri = Uri.parse('App-prefs:root=WIFI');
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      routes: {
        '/home' : (context) => Home()
      },
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Firebase Demo',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromRGBO(246, 130, 13, 1),
        ),
        body: _isConnect
            ? SignInScreen()
            :  Container(
              width: double.infinity,
              height: double.infinity,
              
              child: Builder(
                builder: (context) {
                  return Card(
                    child: AlertDialog(
                        backgroundColor:Color.fromARGB(255, 249, 228, 208),
                        title: const Text('No Internet Connection'),
                        content: const Text('You have lost internet connection. Please check your network settings.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed:(){
                                print('Open Network Connection!');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Open Network Connection!'))
                                );
                              },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                  );
                }
              ),
            ),
      ),
    );
  }
}
