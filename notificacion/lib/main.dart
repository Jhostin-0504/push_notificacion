import 'package:flutter/material.dart';
import 'package:notificacion/screens/home_screens.dart';
import 'package:notificacion/screens/message_screen.dart';
import 'package:notificacion/services/push_notificacion.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificacionService.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    // TODO: implement initState

    //context
    PushNotificacionService.messageStream.listen((message) {
      //   print("My App: $message");
      navigatorKey.currentState?.pushNamed("message", arguments: message);

      final snackBar = SnackBar(content: Text(message));
      messengerKey.currentState?.showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: "home",
      navigatorKey: navigatorKey, // navegar
      scaffoldMessengerKey: messengerKey, //snacks

      routes: {
        'home': (context) => const HomeScreen(),
        'message': (context) => const MessangScreen(),
      },
    );
  }
}
