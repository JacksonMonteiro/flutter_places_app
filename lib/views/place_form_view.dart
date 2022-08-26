import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places/components/base_app_bar.dart';
import 'package:places/components/image_input.dart';
import 'package:places/components/location_input.dart';
import 'package:places/providers/places_provider.dart';
import 'package:provider/provider.dart';

class PlaceFormView extends StatefulWidget {
  const PlaceFormView({Key? key}) : super(key: key);

  @override
  State<PlaceFormView> createState() => _PlaceFormViewState();
}

class _PlaceFormViewState extends State<PlaceFormView> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  LatLng? _pickedPosition;

  void _selectImage(File pickedImage) {
    setState(() {
      _pickedImage = pickedImage;
    });
  }

  void _selectPosition(LatLng pickedPosition) {
    setState(() {
      _pickedPosition = pickedPosition;
    });
  }

  bool _isValidForm() {
    return _titleController.text.isNotEmpty &&
        _pickedImage != null &&
        _pickedPosition != null;
  }

  void _submitForm() {
    if (!_isValidForm()) return;

    Provider.of<PlacesProvider>(context, listen: false).addPlace(
      _titleController.text,
      _pickedImage!,
      _pickedPosition!,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(
          appbar: AppBar(),
          title: 'New Place',
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          labelText: 'Title',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ImageInput(onSelectImage: _selectImage),
                      const SizedBox(
                        height: 10,
                      ),
                      LocationInput(
                        onSelectPosition: _selectPosition,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    primary: Theme.of(context).colorScheme.secondary),
                onPressed: _isValidForm() ? _submitForm : null,
                icon: const Icon(Icons.add),
                label: const Text('Add'),
              ),
            )
          ],
        ));
  }
}
