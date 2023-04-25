import 'firebase_options.dart';
import 'package:scrum/screens/game-pin-screen.dart';

//proper "home" screen should be set when game-pin screen is uploaded
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      title: "SCRUM",
      home: GamePinScreen(),
    ),
  );
}
