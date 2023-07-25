import 'package:complain_me/components/alert_box.dart';
import 'package:complain_me/components/follow_button.dart';
import 'package:complain_me/screens/login_screen.dart';
import 'package:complain_me/services/auth_service.dart';
import 'package:complain_me/services/user_service.dart';
import 'package:complain_me/utilities/app_error.dart';
import 'package:complain_me/utilities/constants.dart';
import 'package:complain_me/utilities/user_api.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final String username;
  const ProfileScreen({Key? key, required this.username}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userSnap = {};
  var postLen = 3;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;
  UserApi userApi = UserApi.instance;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userdata = await UserService().getUserData(widget.username);
      userSnap = userdata[0];
      // get number of Posts
      var postSnap = UserService().getTotalPost(widget.username);
      print(postSnap);      
      followers = userSnap['followers'].length;
      following = userSnap['following'].length;
      isFollowing = userSnap['followers'].contains(userApi.username);
      //postLen = postSnap['length'];

      setState(() {});
    } catch (e) {
        AlertBox.showErrorDialog(
          context,
          AppError(400, e.toString()),
        );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: kColorDark,
              title: Text(
                widget.username,
              ),
              centerTitle: false,
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(
                              kProfImageUrl+userSnap['profImage']!,
                            ),
                            radius: 40,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    buildStatColumn(postLen, "posts"),
                                    buildStatColumn(followers, "followers"),
                                    buildStatColumn(following, "following"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    userApi.username ==
                                            widget.username
                                        ? FollowButton(
                                            text: 'Sign Out',
                                            backgroundColor:
                                                kColorBlack,
                                            textColor: kColorYellow,
                                            borderColor: Colors.grey,
                                            function: () async {
                                              await AuthService().signOut();
                                              if (context.mounted) {
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginScreen(),
                                                  ),
                                                );
                                              }
                                            },
                                          )
                                        : isFollowing
                                            ? FollowButton(
                                                text: 'Unfollow',
                                                backgroundColor: Colors.white,
                                                textColor: Colors.black,
                                                borderColor: Colors.grey,
                                                function: () async {
                                                  await UserService()
                                                      .unfollowUser(
                                                    widget.username,
                                                    userSnap['username']!,
                                                  );
                                                  userSnap['followers'].remove(widget.username);
                                                  setState(() {
                                                    isFollowing = false;
                                                    followers--;
                                                  });
                                                },
                                              )
                                            : FollowButton(
                                                text: 'Follow',
                                                backgroundColor: Colors.blue,
                                                textColor: Colors.white,
                                                borderColor: Colors.blue,
                                                function: () async {
                                                  await UserService()
                                                      .followUser(
                                                    widget.username,
                                                    userSnap['username']!,
                                                  );
                                                  userSnap['followers'].add(widget.username);
                                                  setState(() {
                                                    isFollowing = true;
                                                    followers++;
                                                  });
                                                },
                                              )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(
                          top: 15,
                        ),
                        child: Text(
                          userSnap['username'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(
                          top: 1,
                        ),
                        child: Text(
                          userSnap['bio'],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                FutureBuilder(
                  future: UserService().getUserPostData(widget.username),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 1.5,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {

                        return SizedBox(
                          child: Image(
                            image: NetworkImage(kPostImageUrl +  snapshot.data[index]!['postImage']!),
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  },
                )
              ],
            ),
          );
  }

  Column buildStatColumn(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
