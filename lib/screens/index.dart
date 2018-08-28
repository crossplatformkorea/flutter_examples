import 'package:flutter/material.dart';

import '../models/menu.dart' show Menu;
import '../utils/general.dart';
import '../utils/localization.dart';
import '../utils/theme.dart' as Theme;
import '../shared_widgets/text_input.dart';

class Index extends StatefulWidget {
  Index({Key key}) : super(key: key);

  @override
  IndexState createState() => new IndexState();
}

class IndexState extends State<Index> {
  List<Menu> _init;
  List<Menu> _items;

  bool _icCloseVisible = false;
  bool _hasSearched = false;
  TextEditingController _txtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var localization = Localization.of(context);
    final List<Menu> _init = [
      Menu('Infinite ListView', localization.trans('INFINITE_LIST_VIEW_DESCRIPTION')),
      Menu('Carousel', localization.trans('CAROUSEL_DESCRIPTION')),
    ];

    _items = _init;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        titleSpacing: 0.0,
        brightness: Brightness.dark,
        backgroundColor: Theme.Colors.dodgerBlue,
        title: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            TextInput(
              controller: _txtController,
              textInputAction: TextInputAction.search,
              onChanged: (String str) {
                this.setState(() {
                  _icCloseVisible = str != '';
                  if (_hasSearched && str == '') {
                    _hasSearched = false;
                  }
                });
                this._renderSearched(str);
              },
              onSubmit: (str) {
                this._renderSearched(str);
              },
              background: Colors.transparent,
              txtHint: localization.trans('SEARCH_HINT'),
              underline: false,
              txtHintStyle: TextStyle(
                color:  Color.fromRGBO(255, 255, 255, 0.5),
                fontWeight: FontWeight.w400,
                fontFamily: "AppleSDGothicNeo",
                fontStyle:  FontStyle.normal,
                fontSize: 16.0,
              ),
              padding: EdgeInsets.only(left: 56.0, right: 8.0),
              borderRadius: 40.0,
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              txtStyle: TextStyle(
                color: Colors.white,
                fontFamily: "AppleSDGothicNeo",
                fontStyle:  FontStyle.normal,
                fontSize: 16.0,
              ),
              height: 40.0,
              margin: EdgeInsets.symmetric(horizontal: 16.0),
            ),
            Positioned(
              child: Container(
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                width: 12.0,
                height: 12.0,
              ),
              left: 28.0,
              top: 10.0,
            ),
            this._showIconClear(),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${_items[index].title}'),
            subtitle: Text('${_items[index].description}'),
            onTap: () {
              switch(index) {
                case 0:
                  this._navigate('/infinite_list_ex');
                  break;
                case 1:
                  this._navigate('/carousel_ex');
                  break;
              }
            },
          );
        },
      ),
    );
  }

  Widget _showIconClear() {
    if (this._icCloseVisible) {
      return Positioned(
        child: Container(
          child: RawMaterialButton(
            onPressed: () {
              this.setState(() {
                _icCloseVisible = false;
                _txtController.text = '';
                _hasSearched = false;
                _items = _init;
              });
            },
            child: Icon(
              Icons.clear,
              color: Colors.white,
            ),
            padding: EdgeInsets.all(0.0),
          ),
          width: 40.0,
          height: 40.0,
        ),
        right: 20.0,
      );
    }
    return Container(
      width: 40.0,
      height: 40.0,
    );
  }

  void _renderSearched(String str) {
    _items = _init.where((item) => item.title.contains(str) || item.description.contains(str)).toList();
    // print('${_items.toString()}');
  }

  _navigate(String path) {
    General.instance.navigateScreenNamed(context, path, reset: false);
  }
}
