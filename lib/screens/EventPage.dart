import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nust_hub_1/models/events_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {
  EventModel? event;

  EventPage({this.event});

  @override
  State<EventPage> createState() => _EventPageState(event: event);
}

class _EventPageState extends State<EventPage> {
  EventModel? event;
  String? _imageUrl;
  _EventPageState({this.event});
  Future<String> downloadURL() async{
     
     
     final ref = await FirebaseStorage.instance.ref().child(event!.name.toString()).child(event!.imageUrl.toString());
     _imageUrl = await ref.getDownloadURL();
     print(downloadURL());
     return _imageUrl.toString();
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.only(top: 70),
      padding: const EdgeInsets.all(0),
      height: MediaQuery.of(context).size.height,
      width: 500.0,
      // alignment: FractionalOffset.center,
      child: Column(
        //alignment:new Alignment(x, y)
        children: <Widget>[
          Container(
            height: 250,
            margin: const EdgeInsets.all(30),
            
            
                  child: FutureBuilder(
            future: downloadURL(),
            builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
              if (asyncSnapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Expanded(
                    child: Image.network(_imageUrl.toString(),
                    width: 100,
                    height: 100,));
              }
            }) ,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                this.event!.name!,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                    color: Colors.blueAccent),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.calendar_month,
                color: Colors.blueAccent,
              ),
              Text(this!.event!.date!),
            ],
          ),
          SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(left: 20, right: 20),
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.house_outlined,
                  color: Colors.blueAccent,
                ),
                Text(" "),
                Text(this!.event!.society_name!),
                SizedBox(width: 20),
                Text("|"),
                SizedBox(width: 20),
                Icon(
                  Icons.price_change_outlined,
                  color: Colors.blueAccent,
                ),
                Text(" Rs. "),
                Text(this!.event!.ticket_price!),
              ],
            ),
          ),
          SizedBox(height: 40),
          Text(
            "ABOUT",
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 20, color: Colors.black),
          ),
          Container(
            padding: const EdgeInsets.only(left: 35, right: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Text(
                    this.event!.description!,
                    softWrap: true,
                    maxLines: 5,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 40),
          ElevatedButton(onPressed: () {}, child: Text("Buy Tickets"))
        ],
      ),
    ));
  }
}