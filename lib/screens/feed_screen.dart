import 'package:complain_me/components/post_card.dart';
import 'package:complain_me/services/post_service.dart';
import 'package:complain_me/utilities/constants.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorDark,
        centerTitle: false,
        title: Text("ComplainMe"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.messenger_outline,
            ),
          ),
        ],
      ),
      body: FutureBuilder(

        future: PostService().getPosts(),
        builder: (context,
            AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) => PostCard(
              snap:snapshot.data[index]!,
            ),
          );
        },
      ),
    );
  }
}
