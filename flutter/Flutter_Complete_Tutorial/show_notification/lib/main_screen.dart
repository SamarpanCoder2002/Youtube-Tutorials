import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  _initialize() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Color(0xffe8e5e8),
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark));
  }

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffe8e5e8),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Center(
            child: ElevatedButton(
                onPressed: _showNotification,
                child: const Text(
                  'Show Notification',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                )),
          ),
        ));
  }

  void _showNotification() async {
    final _status = await Permission.notification.request();

    if (_status != PermissionStatus.granted) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Notification Permission Denied')));
      return;
    }

    final _flutterLocalNotificationPlugin = FlutterLocalNotificationsPlugin();
    final _androidInitializationSettings =
        AndroidInitializationSettings('app_icon');

    final _darwinInitializationSettings = DarwinInitializationSettings();

    InitializationSettings _initializationSettings = InitializationSettings(
        android: _androidInitializationSettings,
        iOS: _darwinInitializationSettings);

    await _flutterLocalNotificationPlugin.initialize(_initializationSettings);

    final _androidNotificationDetails = AndroidNotificationDetails(
        'high_importance_channel', 'show_notification',
        importance: Importance.max, priority: Priority.high);

    final _iosNotificationDetails = DarwinNotificationDetails(badgeNumber: 1);

    NotificationDetails _notificationDetails = NotificationDetails(
        android: _androidNotificationDetails, iOS: _iosNotificationDetails);

    _flutterLocalNotificationPlugin.show(0, 'Welcome to this Flutter Series',
        'Learn Flutter from Basic to Advance', _notificationDetails);
  }
}
