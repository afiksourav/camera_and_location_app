import 'dart:io';
import 'package:camera_nad_location_app/helpers/db_helpers.dart';
import 'package:camera_nad_location_app/helpers/location_helper.dart';
import 'package:camera_nad_location_app/models/place.dart';
import 'package:flutter/cupertino.dart';

class GreatPlaces with ChangeNotifier {
  late List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  //add new places provider method logic
    Future<void> addPlace(
    String pickedTitle,
    File pickedImage,
    PlaceLocation pickedLocation,
  ) async {
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude, pickedLocation.longitude);
    final updatedLocation = PlaceLocation(
      address,
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude);
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: updatedLocation,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location!.latitude,
      'loc_lng': newPlace.location!.longitude,
      'address': newPlace.location!.address,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (e) => Place(
            id: e['id'],
            title: e['title'],
            location: null,
            image: File(e['image']),
          ),
        )
        .toList();
        notifyListeners();
  }
}


  //                                                       //2nd
  // void addPlace(String pickedTitle, File pickedImage, PlaceLocation pickedLocation) {
    
    
  //   final newPlace = Place(
  //     id: DateTime.now().toString(),
  //     title: pickedTitle,
  //     location: pickedLocation,  //2nd//null
  //     image: pickedImage,
  //   );
  //   _items.add(newPlace);
  //   notifyListeners();
  //   DBHelper.insert('user_places', {
  //     'id': newPlace.id,
  //     'title': newPlace.title,
  //     'image': newPlace.image.path, // image er jonno path likhte hobe
  //   });
  // }