import 'package:flutter/material.dart';
import 'package:reog_apps_flutter/src/screens/pages/wallpaper_details_page.dart';
import 'package:reog_apps_flutter/src/screens/widgets/wallpaper_item.dart';

class WallpaperPage extends StatefulWidget {
  @override
  _WallpaperPageState createState() => _WallpaperPageState();
}

class _WallpaperPageState extends State<WallpaperPage> {
  ScrollController _scrollViewController;
  List<String> _urls;

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_urls == null) {
      _urls = List<String>();
    }

    setDummyArticles();

    return Scaffold(
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text('Wallpaper'),
              floating: true,
              snap: true,
              forceElevated: innerBoxIsScrolled,
            ),
          ];
        },
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
          ),
          itemCount: _urls.length,
          padding: EdgeInsets.all(3.0),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              child: WallpaperItem(_urls[index]),
              onTap: () async {
                bool result = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return WallpaperDetailsPage(_urls[index]);
                }));
                print(result);
              },
            );
          },
        ),
      ),
    );
  }

  void setDummyArticles() {
    for (int i = 0; i < 20; i++) {
      _urls.add((i % 2 == 0)
          ? 'https://1.bp.blogspot.com/-11c9jnZJ6UE/X2tLBOww-UI/AAAAAAAAAGw/dtX0eqmMlhArj3OtOGx95SATIzn2NzE8ACLcBGAsYHQ/s266/Screenshot%2Bfrom%2B2019-10-22%2B09-29-01.png'
          : (i % 3 == 0)
              ? 'https://1.bp.blogspot.com/-DjP5PsDGZMs/X2tLDme0IQI/AAAAAAAAAHE/O4n8xbcYiAUn3IVHg3qt1YopgZcUvmO3wCLcBGAsYHQ/s388/Screenshot%2Bfrom%2B2019-10-22%2B10-06-54.png'
              : 'https://commons.wikimedia.org/wiki/File:Potrait_of_Faizi.jpg');
    }
  }
}
