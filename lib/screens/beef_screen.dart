import 'dart:convert';

import 'package:complain_me/models/beef.dart';
import 'package:flutter/material.dart';
import 'package:complain_me/components/alert_box.dart';
import 'package:complain_me/components/Beef_card.dart';
import 'package:complain_me/components/search_box.dart';
import 'package:complain_me/models/Beef.dart';
import 'package:complain_me/models/complain.dart';
import 'package:complain_me/screens/complain_screen.dart';
import 'package:complain_me/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:complain_me/utilities/user_api.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class BeefScreen extends StatefulWidget {
  @override
  _BeefScreenState createState() => _BeefScreenState();

  final String city, state, country, categoryId, popular;
  BeefScreen(
      {required this.city,
      required this.state,
      required this.country,
      required this.categoryId,
      required this.popular});
}

class _BeefScreenState extends State<BeefScreen> {
/*   UserApi userApi = UserApi.instance;
  late String searchText;
  bool _loading = false;
  late Map filterMap;
  late Widget filterAppliedBar;

  List<Beef> allBeefs = [];
  List<Widget> BeefsToDisplay = [];
  List<Widget> BeefsToDisplayAll = [
    Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
          child: CircularProgressIndicator(
            strokeWidth: 4,
          ),
        ),
      ),
    ),
  ];

  Future<void> openComplain(Beef beef) async {
    setState(() {
      _loading = true;
    });
    final http.Response response =
        await http.post(Uri.parse(kOpenComplainUrl), body: {
      'city_name': userApi.cityName,
      'state_name': userApi.stateName,
      'country_name': userApi.countryName,
      'id': beef.complainId,
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      // Connection established
      var data = jsonDecode(response.body.toString());
      if (data.toString() == 'Error loading data') {
        setState(() {
          _loading = false;
        });
        AlertBox.showErrorBox(
            context, 'Unable to get the complain information');
      } else {
        Complain complain = Complain(
          id: data[0]['id'],
          name: data[0]['name'],
          streetName: data[0]['street_name'],
          cityName: data[0]['city_name'],
          stateName: data[0]['state_name'],
          postalCode: data[0]['postal_code'],
          countryName: data[0]['country_name'],
          phoneNumber: data[0]['phone_number'],
          latitude: double.parse(data[0]['latitude']),
          longitude: double.parse(data[0]['longitude']),
          number: double.parse(data[0]['number']),
          hashtag: data[0]['hash_tag'],
          imageUrl: data[0]['image_url'],
        );
        setState(() {
          _loading = false;
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ComplainScreen(complain: complain, specificBeef: beef)));
      }
    } else {
      // Connection not established
      setState(() {
        _loading = false;
      });
      AlertBox.showErrorBox(
          context, 'Unable to establish connection with the server');
    }
  }

  Future<void> loadBeefs() async {
    allBeefs = [];
    final http.Response response =
        await http.post(Uri.parse(kLoadBeefsUrl), body: {
      'city_name': widget.city,
      'state_name': widget.state,
      'country_name': widget.country,
      'category_id': widget.categoryId,
      'popular': widget.popular,
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      // Connection established
      var data = jsonDecode(response.body.toString());
      if (data.toString() == 'Error loading data') {
        AlertBox.showErrorBox(context, 'Unable to load data');
      } else {
        for (Map map in data) {
          Beef beef = Beef(
            id: map['id'],
            name: map['name'],
            complainId: map['complain_id'],
            categoryId: map['category_id'],
            number: double.parse(map['number']),
            imageUrl: map['image_url'],
            cityName: map['city_name'],
            stateName: map['state_name'],
            countryName: map['country_name'],
            categoryName: map['category_name'],
            complainName: map['complain_name'],
          );
          print('unfiltered list');
          allBeefs.add(beef);
        }
        generateDisplayWidget(allBeefs);
      }
    } else {
      // Error establishing connection with the server
      AlertBox.showErrorBox(context,
          'Unable to establish connection with the servers.\nERROR CODE: ${response.statusCode}');
    }
  }

  void generateDisplayWidget(List inputList) {
    List<Widget> myList = [];
    for (var beef in inputList) {
      myList.add(
        BeefCard(
          beef: beef,
          onPressed: () {
            openComplain(beef);
          },
        ),
      );
    }
    setState(() {
      BeefsToDisplayAll = myList;
    });
  }

  bool applyFilter(Map filterMap, Beef Beef) {
    @override
    void initState() {
      super.initState();
      loadBeefs();
    }

    @override
    Widget build(BuildContext context) {
      if (searchText == "null") {
        BeefsToDisplay = BeefsToDisplayAll;
      }


      if (filterMap != null) {
        filterAppliedBar = Positioned(
          bottom: 0,
          left: 0,
          child: GestureDetector(
            onTap: () {
              setState(() {
                generateDisplayWidget(allBeefs);
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              decoration: BoxDecoration(
                color: kColorRed,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Text(
                  'Filter applied. Tap to remove',
                  style:
                      kLabelStyle.copyWith(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
        );
      } else {
        filterAppliedBar = Container();
      }

      return ModalProgressHUD(
        inAsyncCall: _loading,
        color: Colors.white,
        opacity: .5,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.0),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  padding: EdgeInsets.all(10),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: kColorBlack,
                  ),
                ),
              ),
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.only(top: 27),
                child: Text(
                  'HUNGRYYY',
                  style: kHeadingStyle,
                ),
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
                  child: IconButton(
                    onPressed: () {
                      //Navigator.pushReplacementNamed(context, CartScreen.id);
                    },
                    padding: EdgeInsets.all(10),
                    icon: Icon(
                      Icons.shopping_cart,
                      color: kColorBlack,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    child: SearchBox(
                      hint: 'Search Food',
                      onChanged: (value) {
                        if (value.toString().trim().isEmpty) {
                          setState(() {
                            searchText = "null";
                          });
                        } else {
                          searchText = value.toString().toLowerCase();
                          List<Beef> filteredList = filteredBeefs
                              .where((beef) =>
                                  beef.name.toLowerCase().contains(searchText))
                              .toList();
                          List<Widget> myList = [];
                          for (var Beef in filteredList) {
                            myList.add(
                              BeefCard(
                                beef: beef,
                                onPressed: () {
                                  openComplain(Beef);
                                },
                              ),
                            );
                          }
                          setState(() {
                            BeefsToDisplay = myList;
                          });
                        }
                      },
                      onPressed: () {
                        showFilterCard();
                      },
                    ),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: loadBeefs,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: BeefsToDisplay,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              filterAppliedBar,
            ],
          ),
        ),
      );
    }
  }
 */
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
