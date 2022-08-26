import 'package:flutter/material.dart';
import 'package:places/components/base_app_bar.dart';
import 'package:places/providers/places_provider.dart';
import 'package:places/utils/app_routes.dart';
import 'package:provider/provider.dart';

class PlacesListView extends StatelessWidget {
  const PlacesListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        appbar: AppBar(),
        title: 'My places',
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.PLACE_FORM);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<PlacesProvider>(context, listen: false).getPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<PlacesProvider>(
                child: const Center(
                  child: Text('No Locals Saved'),
                ),
                builder: (context, placeProvider, child) => placeProvider
                            .itemsCount ==
                        0
                    ? child!
                    : ListView.builder(
                        itemCount: placeProvider.itemsCount,
                        itemBuilder: (context, index) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage: FileImage(
                                    placeProvider.getItem(index).image),
                              ),
                              title: Text(placeProvider.getItem(index).title),
                              subtitle: Text(placeProvider
                                  .getItem(index)
                                  .location
                                  .address
                                  .toString()),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    AppRoutes.PLACE_DETAIL,
                                    arguments: placeProvider.getItem(index));
                              },
                            )),
              ),
      ),
    );
  }
}
