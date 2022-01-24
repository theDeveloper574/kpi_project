import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Submit extends StatefulWidget {
  @override
  _SubmitState createState() => new _SubmitState();
}

class _SubmitState extends State<Submit> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();
  final myController = new TextEditingController();
  double _w;
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    myController.dispose();
    super.dispose();
  }

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      _performSubmit();
    }
  }

  void _performSubmit() {
    final double data = double.parse(myController.text) * (2);
    var route = new MaterialPageRoute(
      builder: (BuildContext context) => new NextPage(
        w1: new Entry(
          'First',
          <Entry>[new Entry('$data')],
        ),
      ),
    );

    Navigator.of(context).push(route);
  }

  @override
  Widget build(BuildContext context) {
    void _restart() {
//      Navigator.of(context).push(new MaterialPageRoute(
//          builder: (BuildContext context) => new HomePage()));
    }

    return new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
        actions: <Widget>[],
        title: new Text('Next Page'),
      ),
      body: new Form(
        key: formKey,
        child: new Column(
          children: [
            new TextFormField(
              controller: myController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSaved: (val) => _w = double.parse(val),
            ),
            new RaisedButton(
              onPressed: _submit,
              child: new Text(
                'Next Page',
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NextPage extends StatefulWidget {
  final Entry w1;

  NextPage({Key key, this.w1}) : super(key: key);

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text("Second page")),
      body: new EntryItem(widget.w1),
    );
  }
}

class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}

class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty)
      return new ListTile(
          title: new Text(root.title));

    return new ExpansionTile(
      key: new PageStorageKey<Entry>(root),
      title: new Text(root.title,),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}