import 'package:camera_nad_location_app/Providers/great_places.dart';
import 'package:camera_nad_location_app/screens/add_place_screen.dart';
import 'package:camera_nad_location_app/screens/places_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Greate Place',
        theme: ThemeData(
        //  primarySwatch: Colors.indigo,
         // accentColor: Colors.amber
        ),
        home: const PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName:(context) => const AddPlaceScreen()
        },
      ),
    );
  }
}