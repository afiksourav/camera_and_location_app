import 'dart:io';

import 'package:camera_nad_location_app/Providers/great_places.dart';
import 'package:camera_nad_location_app/widgets/Location_input.dart';
import 'package:camera_nad_location_app/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/place.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});

  static const routeName = '/add-place';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();

  late File _pickedImage;
  late PlaceLocation  _placeLocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

 void _selectPlace(double lat, double lng) {
    _placeLocation = PlaceLocation('', latitude: lat, longitude: lng);
  }

void _savePlace() {
     // ignore: unnecessary_null_comparison
     if (_titleController.text.isEmpty || _pickedImage == null|| _placeLocation == null) {
      return;
    } 
    Provider.of<GreatPlaces>(context, listen: false).addPlace(_titleController.text, _pickedImage, _placeLocation);
    Navigator.of(context).pop();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: const InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                   const SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectImage),
                    const SizedBox(height: 15,),
                      LocationInput(_selectPlace)
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Add Place'),
            onPressed: _savePlace,
     
          ),
        ],
      ),
    );
  }
}
