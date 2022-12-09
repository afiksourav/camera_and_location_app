import 'package:camera_nad_location_app/Providers/great_places.dart';
import 'package:camera_nad_location_app/screens/add_place_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: 
    const  Text('Your Places'),
      actions: [
        IconButton(onPressed: (){
     Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
        }, icon: const Icon(Icons.add))
      ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context,listen: false).fetchAndSetPlaces(),
        builder:(context, snapshot) => snapshot.connectionState == ConnectionState.waiting ? 
        const Center(child: CircularProgressIndicator(),): Consumer<GreatPlaces>(
          child: const Center(
            child: Text('Got no places yet, start adding some !'),
          ),
          // ignore: prefer_is_empty
          builder: (context, greatPlaces,  child) =>  greatPlaces.items.length <= 0
              ? child!
              : ListView.builder(
                  itemCount: greatPlaces.items.length,
                  itemBuilder: (ctx, i) => ListTile(
                        leading: CircleAvatar(
                          backgroundImage: FileImage(
                            greatPlaces.items[i].image,
                          ),
                        ),
                        title: Text(greatPlaces.items[i].title),
                        subtitle: Text(greatPlaces.items[i].location!.address),
                        onTap: () {
                          // Go to detail page ...
                        },
                      ),
                ),
          
        ),
      ),
       
      
    );
  }
}