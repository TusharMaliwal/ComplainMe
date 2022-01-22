import 'package:flutter/material.dart';
import 'package:complain_me/models/beef.dart';
import 'package:complain_me/utilities/constants.dart';

class BeefCard extends StatelessWidget {

  final Beef beef;
  final Function onPressed;
  BeefCard({required this.beef,required this.onPressed});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onPressed(),
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
        width: double.infinity,
        height: 230,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: kColorBlack.withOpacity(0.1),
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(beef.imageUrl),
                      fit: BoxFit.cover
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
             beef.name,
              style: TextStyle(
                fontFamily: 'GT Eesti',
                fontSize: 20,
              ),
            ),
            Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.spaceBetween,
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
                      beef.complainName,
                      style: TextStyle(
                        fontFamily: 'GT Eesti',
                        fontSize: 16,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      '⭐ ',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      '${beef.number}',
                      style: TextStyle(
                          fontFamily: 'GT Eesti',
                          fontSize: 12
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}