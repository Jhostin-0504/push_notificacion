// SHA1
// AC:B1:AF:7B:E0:BB:9B:84:63:F6:CE:BA:EA:F6:AE:5F:41:E6:BD:3B

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificacionService {
  static FirebaseMessaging message = FirebaseMessaging.instance;
  static String? token;
  // ignore: prefer_final_fields
  static StreamController<String> _messaStream =
      // ignore: unnecessary_new
      new StreamController.broadcast();
  static Stream<String> get messageStream => _messaStream.stream;

  static Future _bakgraundHandler(RemoteMessage message) async {
    print("onBackgraund handler ${message.data["producto"]}");
    //_messaStream.add(message.notification?.body /*title*/ ?? "No titulo");
    print(message.data);
    _messaStream.add(message.data["producto"] /*title*/ ?? "No data");
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    print("onMessage Handler ${message.data["producto"]}");
    //_messaStream.add(message.notification?.body /*title*/ ?? "No titulo");
    print(message.data);
    _messaStream.add(message.data["producto"] /*title*/ ?? "No data");
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    print("onMessage OpenApp ${message.data["producto"]}");
    print(message.data);
    //_messaStream.add(message.notification?.body /*title*/ ?? "No titulo");
    _messaStream.add(message.data["producto"] /*title*/ ?? "No data");
  }

  static Future initializeApp() async {
    //push notificacion

    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print("token: $token");

    //Handlers
    FirebaseMessaging.onBackgroundMessage(_bakgraundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
    //local notificacion
  }

  static closeStreams() {
    _messaStream.close();
  }
}
