import 'dart:convert';

import 'package:complain_me/components/complain_card.dart';
import 'package:complain_me/models/complain.dart';
import 'package:flutter/material.dart';
import 'package:complain_me/components/alert_box.dart';
import 'package:complain_me/components/category_card.dart';
import 'package:complain_me/components/beef_card.dart';
import 'package:complain_me/components/search_box.dart';
import 'package:complain_me/components/showcase_card.dart';
import 'package:complain_me/models/category.dart';
import 'package:complain_me/models/beef.dart';
import 'package:complain_me/screens/beef_screen.dart';
import 'package:complain_me/screens/all_complains_screen.dart';
import 'package:complain_me/screens/navigation_screens/my_address_screen.dart';
import 'package:complain_me/screens/complain_screen.dart';
import 'package:complain_me/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:complain_me/utilities/user_api.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();

  final Widget iconButton;
  SearchPage({required this.iconButton});
}

class _SearchPageState extends State<SearchPage> {

  UserApi userApi = UserApi.instance;
  String searchText = "null";
  bool _loading = false;
  bool displayCategories = true;
  bool displayComplains = true;
  bool displayMostPopular = true;

  List<Category> allCategories = [];
  List<Complain> allComplains = [];

  late List<Widget> categoriesToDisplay;
  List<Widget> categoriesToDisplayAll = [
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 50),
      child: CircularProgressIndicator(
        strokeWidth: 4,
      ),
    ),
  ];

  List<Widget> ComplainsToDisplay = [
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 50),
      child: CircularProgressIndicator(
        strokeWidth: 4,
      ),
    ),
  ];

  Widget mostPopularBeef = Padding(
    padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 50),
    child: CircularProgressIndicator(
      strokeWidth: 4,
    ),
  );

  Future<void> openComplain(Beef beef) async {
    setState(() {
      _loading = true;
    });
    final http.Response response = await http.post(Uri.parse(kLoadComplainsUrl),body: {
      'city_name': userApi.cityName,
      'state_name' : userApi.stateName,
      'country_name' : userApi.countryName,
      'id' : beef.complainId,
    });
    if(response.statusCode == 200 || response.statusCode == 201){
      // Connection established
      var data = jsonDecode(response.body.toString());
      if(data.toString() == 'Error loading data'){
        setState(() {
          _loading = false;
        });
        AlertBox.showErrorBox(context,'Unable to get the complain information');
      }else{
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
        Navigator.push(context, MaterialPageRoute(builder: (context) => ComplainScreen(complain: complain,specificBeef: beef)));
      }
    }else{
      // Connection not established
      setState(() {
        _loading = false;
      });
      AlertBox.showErrorBox(context,'Unable to establish connection with the server');
    }
  }

  Future<void> loadMostPopular() async {
    final http.Response response = await http.post(Uri.parse(kMostPopularBeefUrl),body: {
      'city_name': userApi.cityName,
      'state_name' : userApi.stateName,
      'country_name' : userApi.countryName,
    });
    if(response.statusCode == 200 || response.statusCode == 201){
      // Connection established
      var data = jsonDecode(response.body.toString());
      if(data.toString() == 'Error loading data'){
        AlertBox.showErrorBox(context,'Unable to load popular Complains near you');
        setState(() {
          displayMostPopular = false;
        });
      }else{
          Beef beef = Beef(
          id: data[0]['id'],
          name: data[0]['name'],
          complainId: data[0]['complain_id'],
          categoryId: data[0]['category_id'],
          number: double.parse(data[0]['number']),
          imageUrl: data[0]['image_url'],
          cityName: data[0]['city_name'],
          stateName: data[0]['state_name'],
          countryName: data[0]['country_name'],
          categoryName: data[0]['category_name'],
          complainName: data[0]['complain_name'],
        );
        setState(() {
          mostPopularBeef = BeefCard(
            beef: beef,
            onPressed: (){
              openComplain(beef);
            },
          );
        });
        if(beef == null){
          setState(() {
            displayMostPopular = false;
          });
        }
      }
    }else{
      // Connection not established
      AlertBox.showErrorBox(context,'Unable to establish connection with the server');
      setState(() {
        displayMostPopular = false;
      });
    }
  }

  Future<void> loadcomplains() async {
    allComplains = [];
    final http.Response response = await http.post(Uri.parse(kLoadComplainsUrl),body: {
      'city_name': userApi.cityName,
      'state_name' : userApi.stateName,
      'country_name' : userApi.countryName,
    });
    if(response.statusCode == 200 || response.statusCode == 201){
      // Connection established
      var data = jsonDecode(response.body.toString());
      if(data.toString() == 'Error loading data'){
        AlertBox.showErrorBox(context,'Unable to load complains near you.');
        setState(() {
          displayComplains = false;
        });
      }else{
        List<Widget> myList = [];
        for(Map map in data){
          Complain complain = Complain(
            id: map['id'],
            name: map['name'],
            streetName: map['street_name'],
            cityName: map['city_name'],
            stateName: map['state_name'],
            postalCode: map['postal_code'],
            countryName: map['country_name'],
            phoneNumber: map['phone_number'],
            latitude: double.parse(map['latitude']),
            longitude: double.parse(map['longitude']),
            number: double.parse(map['number']),
            hashtag: map['hashtag'],
            imageUrl: map['image_url'],
          );
          allComplains.add(complain);
        }
        int n = 0;
        for(var complain in allComplains){
          n++;
          if(n == 5){
            break;
          }
          myList.add(
            ComplainCard(
              complain: complain,
            ),
          );
          setState(() {
            ComplainsToDisplay = myList;
          });
        }
        if(myList.isEmpty){
          setState(() {
            displayComplains = false;
          });
        }else{
          setState(() {
            ComplainsToDisplay = myList;
          });
        }
      }
    }else{
      // Connection not established
      AlertBox.showErrorBox(context,'Unable to establish connection with the server');
      setState(() {
        displayComplains = false;
      });
    }
  }

  Future<void> loadCategories() async {
    allCategories = [];
    final http.Response response = await http.post(Uri.parse(kLoadCategoriesUrl),body: {
      'city_name': userApi.cityName,
      'state_name' : userApi.stateName,
      'country_name' : userApi.countryName,
    });
    if(response.statusCode == 200 || response.statusCode == 201){
      // Connection established
      var data = jsonDecode(response.body.toString());
      if(data.toString() == 'Error loading data'){
        AlertBox.showErrorBox(context,'Unable to load categories of food near you.');
        setState(() {
          displayCategories = false;
        });
      }else{
        List<Widget> myList = [];
        for(Map map in data){
          Category category = Category(
            name: map['category_name'],
            id: map['category_id'],
          );
          if(category.id != 'category_other'){
            allCategories.add(category);
          }
        }
        for(var category in allCategories){
          myList.add(
            CategoryCard(
              category: category,
              onPressed: (){
                Navigator.push(context,MaterialPageRoute(
                  builder: (context) => BeefScreen(
                    city: userApi.cityName!,
                    state: userApi.stateName!,
                    country: userApi.countryName!,
                    categoryId: category.id,
                    popular: 'NO',
                  ),
                ));
              },
            ),
          );
        }
        if(myList.isEmpty){
          setState(() {
            displayCategories = false;
          });
        }else{
          setState(() {
            displayCategories = true;
            categoriesToDisplayAll = myList;
          });
        }
      }
    }else{
      // Connection not established
      AlertBox.showErrorBox(context,'Unable to establish connection with the server');
      setState(() {
        displayCategories = false;
      });
    }
  }

  Future<void> loadData() async {
    await loadCategories();
    await loadcomplains();
    await loadMostPopular();
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }



  @override
  Widget build(BuildContext context) {

    if(searchText == "null"){
      categoriesToDisplay = categoriesToDisplayAll;
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
              child: widget.iconButton,
            ),
            centerTitle: false,
            title: Padding(
              padding: const EdgeInsets.only(top: 27),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyAddressScreen(
                      iconButton: IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        padding: EdgeInsets.all(10),
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: kColorBlack,
                        ),
                      ),
                    onAddressChange: (){
                        SearchPage(iconButton: widget.iconButton,).createState();
                    },
                  )));
                },
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Deliver To',
                      style: TextStyle(
                        fontFamily: 'GT Eesti',
                        color: kColorBlack,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      '${userApi.streetName}, ${userApi.cityName} >',
                      style: TextStyle(
                        fontFamily: 'GT Eesti',
                        color: Colors.grey.shade500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
                child: IconButton(
                  onPressed: () {
                    //Navigator.pushNamed(context,CartScreen.id);
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
        body: RefreshIndicator(
          onRefresh: loadData,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                  child: Text(
                    'Find any complain In',
                    style: kHeadingStyle,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
                  child: Text(
                    'Your City 😉',
                    style: kHeadingStyle,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                  child: SearchBox(
                    hint: 'Search Categories',
                    onChanged:() {
                      /* if(value.toString().trim().isEmpty){
                        setState(() {
                          searchText = "null";
                        });
                      }else{
                        searchText = value.toString().toLowerCase();
                        List<Category> filteredList = allCategories.where((category) => category.name.toLowerCase().contains(searchText)).toList();
                        List<Widget> myList = [];
                        for(var category in filteredList){
                          myList.add(
                            CategoryCard(
                              category: category,
                              onPressed: (){
                                Navigator.push(context,MaterialPageRoute(
                                  builder: (context) => BeefScreen(
                                    city: userApi.cityName!,
                                    state: userApi.stateName!,
                                    country: userApi.countryName!,
                                    categoryId: category.id,
                                    popular: 'NO',
                                  ),
                                ));
                              },
                            ),
                          );
                        }
                        setState(() {
                          categoriesToDisplay = myList;
                        });
                      } */
                    },
                    onPressed: (){
                      //showFilterCard();
                    },
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                displayCategories ?
                    Column(
                      children: <Widget>[
                        ShowcaseCard(
                          label: 'Categories',
                          viewAll: () {
                            Navigator.push(context,MaterialPageRoute(
                                builder: (context) => BeefScreen(
                                  city: userApi.cityName!,
                                  state: userApi.stateName!,
                                  country: userApi.countryName!,
                                  categoryId: 'none',
                                  popular: 'NO',
                                ),
                            ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20)  ,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: categoriesToDisplay,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    )
                    : Container(),
                displayComplains ?
                    Column(
                      children: <Widget>[
                        ShowcaseCard(
                          label: 'Near You',
                          viewAll: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllComplainScreen(complain: allComplains,),
                              ),
                            );
                          },
                          child: Container(
                            height: 270,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: ComplainsToDisplay,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ):Container(),
                ShowcaseCard(
                  label: 'Most Popular',
                  viewAll: (){
                    Navigator.push(context,MaterialPageRoute(
                      builder: (context) => BeefScreen(
                        city: userApi.cityName!,
                        state: userApi.stateName!,
                        country: userApi.countryName!,
                        categoryId: 'none',
                        popular: 'YES',
                      ),
                    ));
                  },
                  child: mostPopularBeef,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}