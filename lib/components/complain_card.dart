import 'package:complain_me/models/complain.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:complain_me/screens/complain_screen.dart';
import 'package:complain_me/utilities/constants.dart';
import 'package:complain_me/utilities/user_api.dart';

class ComplainCard extends StatefulWidget {
  @override
  _ComplainCardState createState() => _ComplainCardState();

  final Complain complain;
  ComplainCard({required this.complain});
}

class _ComplainCardState extends State<ComplainCard> {
  double distance = 0;
  UserApi userApi = UserApi.instance;

  Future<void> calculateDistance() async {
    distance = await Geolocator.distanceBetween(widget.complain.latitude,
        widget.complain.longitude, userApi.latitude!, userApi.longitude!);
    distance = distance / 1000;
    distance = distance.roundToDouble();

    setState(() {
      distance = distance;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ComplainScreen(
              complain: widget.complain,
            ),
          ),
        );
      },
      child: Container(
        width: 170,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: kColorBlack.withOpacity(0.1),
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.complain.imageUrl),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.complain.name,
              style: TextStyle(
                fontFamily: 'GT Eesti',
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Wrap(
              direction: Axis.horizontal,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      color: kColorRed,
                      size: 12,
                    ),
                    Text(
                      '$distance km',
                      style: TextStyle(
                        fontFamily: 'GT Eesti',
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Text(' • '),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.hail_sharp,
                      color: kColorRed,
                      size: 12,
                    ),
                    Text(
                      '${widget.complain.hashtag}',
                      style: TextStyle(
                        fontFamily: 'GT Eesti',
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Wrap(
              direction: Axis.horizontal,
              children: <Widget>[
                Text(
                  '⭐ ',
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
                Text(
                  '${widget.complain.number}',
                  style: TextStyle(fontFamily: 'GT Eesti', fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
