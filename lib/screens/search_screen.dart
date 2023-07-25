import 'package:complain_me/services/post_service.dart';
import 'package:complain_me/services/user_service.dart';
import 'package:complain_me/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;
  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kColorYellow,
        title: TextFormField(
          controller: searchController,
          decoration: const InputDecoration(
            labelText: 'Search for a User',
          ),
          onFieldSubmitted: (String _) {
            setState(() {
              isShowUsers = true;
            });
          },
        ),
      ),
      body: isShowUsers
          ? FutureBuilder(
              future: UserService().getUser(searchController.text),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(kProfImageUrl+
                            (snapshot.data[index]!
                                ['profImage'])),
                      ),
                      title: Text(
                          snapshot.data[index]!['username']),
                    );
                  },
                );
              })
          : FutureBuilder(
              future: PostService().getPosts(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return StaggeredGridView.countBuilder(
                  crossAxisCount:3,
                  itemCount:snapshot.data!.length,
                  itemBuilder: (context, index)=>Image.network(
                    kPostImageUrl+ snapshot.data[index]!['postImage']
                  ),
                  staggeredTileBuilder: (index)=>StaggeredTile.count(
                    (index%7==0)?2:1,
                    (index%7==0)?2:1,
                  ),
                  mainAxisSpacing:8,
                  crossAxisSpacing:8,
                );
              },
          ),
    );
  }
}
