import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places/models/place.dart';
import 'package:places/utils/db_util.dart';
import 'package:places/utils/location_util.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> _items = [];
  List<Place> get items => [..._items];

  int get itemsCount => _items.length;

  Place getItem(int index) => _items[index];

  Future<void> addPlace(String title, File image, LatLng position) async {
    String address = await LocationUtil.getAddressFrom(position);

    final newPlace = Place(
      id: Random().nextDouble().toString(),
      title: title,
      image: image,
      location: PlaceLocation(
        lat: position.latitude,
        long: position.longitude,
        address: address,
      ),
    );

    _items.add(newPlace);
    DbUtil.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'lat': position.latitude,
      'long': position.longitude,
      'address': address
    });

    notifyListeners();
  }

  Future<void> getPlaces() async {
    final dataList = await DbUtil.getData('places');
    _items = dataList
        .map((item) => Place(
              id: item['id'],
              title: item['title'],
              location: PlaceLocation(
                lat: item['lat'],
                long: item['long'],
                address: item['address'],
              ),
              image: File(item['image']),
            ))
        .toList();

    notifyListeners();
  }
}
