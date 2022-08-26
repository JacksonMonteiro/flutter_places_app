import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places/components/base_app_bar.dart';
import 'package:places/models/place.dart';

class MapView extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isReadOnly;

  const MapView({
    Key? key,
    this.initialLocation = const PlaceLocation(
      lat: 37.419857,
      long: -122.078827,
    ),
    this.isReadOnly = false,
  }) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  LatLng? _pickedPosition;

  void _selectPosition(LatLng position) {
    setState(() {
      _pickedPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(
          appbar: AppBar(),
          title: 'Select a place',
          actions: [
            if (!widget.isReadOnly)
              IconButton(
                  onPressed: _pickedPosition == null
                      ? null
                      : () {
                          Navigator.of(context).pop(_pickedPosition);
                        },
                  icon: const Icon(Icons.check))
          ],
        ),
        body: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(
                  widget.initialLocation.lat, widget.initialLocation.long),
              zoom: 13,
            ),
            onTap: widget.isReadOnly ? null : _selectPosition,
            markers: (_pickedPosition == null && !widget.isReadOnly)
                ? <Marker>{}
                : <Marker>{
                    Marker(
                        markerId: const MarkerId('p1'),
                        position: _pickedPosition ??
                            LatLng(widget.initialLocation.lat,
                                widget.initialLocation.long))
                  }));
  }
}
