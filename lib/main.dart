import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:places/providers/places_provider.dart';
import 'package:places/utils/app_routes.dart';
import 'package:places/views/place_detail_view.dart';
import 'package:places/views/place_form_view.dart';
import 'package:places/views/places_list_view.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeData theme = ThemeData();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PlacesProvider(),
      child: MaterialApp(
        title: 'My Places',
        debugShowCheckedModeBanner: false,
        theme: theme.copyWith(
          useMaterial3: true,
          colorScheme: theme.colorScheme
              .copyWith(primary: Colors.indigo, secondary: Colors.amber),
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.indigo,
              actionsIconTheme: IconThemeData(
                color: Colors.white,
              ),
              iconTheme: IconThemeData(
                color: Colors.white,
              )),
        ),
        home: const PlacesListView(),
        routes: {
          AppRoutes.PLACE_FORM: (context) => const PlaceFormView(),
          AppRoutes.PLACE_DETAIL: (context) => const PlaceDetailView(),
        },
      ),
    );
  }
}
