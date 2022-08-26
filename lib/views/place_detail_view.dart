import 'package:flutter/material.dart';
import 'package:places/components/base_app_bar.dart';
import 'package:places/models/place.dart';
import 'package:places/views/map_view.dart';

class PlaceDetailView extends StatelessWidget {
  const PlaceDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Place place = ModalRoute.of(context)?.settings.arguments as Place;

    return Scaffold(
      appBar: BaseAppBar(
        appbar: AppBar(),
        title: place.title,
      ),
      body: Column(children: [
        Container(
          height: 250,
          width: double.infinity,
          child: Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          place.location.address.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextButton.icon(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => MapView(
                  isReadOnly: true,
                  initialLocation: place.location,
                ),
              ),
            );
          },
          icon: Icon(Icons.map),
          label: Text(
            'See on map',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
      ]),
    );
  }
}
