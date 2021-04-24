import 'package:flutter/material.dart';

import '../search_model.dart';

class SearchLoadedWidget extends StatelessWidget {
  final List<SearchModel> items;

  const SearchLoadedWidget({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final SearchModel item = items[index];

        return InkWell(
          onTap: () => showItem(context, item),
          child: Container(
            alignment: FractionalOffset.center,
            margin: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 16.0),
                  child: Hero(
                    tag: item.fullName,
                    child: ClipOval(
                      child: Image.network(
                        item.avatarUrl,
                        width: 56.0,
                        height: 56.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                          top: 6.0,
                          bottom: 4.0,
                        ),
                        child: Text(
                          "${item.fullName}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          "${item.url}",
                          style: TextStyle(
                            fontFamily: "Hind",
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void showItem(BuildContext context, SearchModel item) {
    Navigator.push(
      context,
      MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: GestureDetector(
              key: Key(item.avatarUrl),
              onTap: () => Navigator.pop(context),
              child: SizedBox.expand(
                child: Hero(
                  tag: item.fullName,
                  child: Image.network(
                    item.avatarUrl,
                    width: MediaQuery.of(context).size.width,
                    height: 300.0,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
