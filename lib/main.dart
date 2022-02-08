import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'magicItemsClass.dart';
//import 'testLiteClass.dart';

// for SQLite
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var databasePath = await getDatabasesPath();
  var path = join(databasePath, "MagicItems3.db");
  var exists = await(databaseExists(path));
  print (databasePath);

  if (!exists) {
    print("Creating new copy from asset");
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (e) {
      print(e);
    }

    // Copy from asset
    ByteData data = await rootBundle.load(
        join("assets/databases/", "LiteMagicItems.db"));
    List<int> bytes =
    data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    // Write and flush the bytes written
    await File(path).writeAsBytes(bytes, flush: true);
  } else {
    print("Opening existing database");
  }
// open the database
  var db = await openDatabase(path, readOnly: true);
  var itemListQueryResult = getMagicItems(db);
  var spellListQueryResult = getSpellList(db);
/*
  t.then((List<TestLite> a)
  {return a.elementAt(2);}).catchError((e)
  {return e;}
  );
*/


  runApp(const MyApp());
  }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magic Items',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Magic Items Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final List<String> _progression = ["slow", "medium", "fast"];
  late String _prog = _progression.elementAt(1);

  final List<String> _ynList = ["yes"];
  late String _rnd = _ynList.elementAt(0);

  final List<String> _encType = ["none specified", "aberration", "animal", "construct", "dragon", "fey", "humanoid", "magical beast", "monstrous humanoid", "oozes", "outsider", "plants", "undead", "vermin"];
  late String _et = _encType.first;
  final List<int> _crList = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22];
  late int _cr = _crList.first;

  final List<String> _crMultiplier = ["incidental-50%", "standard-100%", "double-200%", "triple-300%"];
  late String _crM = _crMultiplier.elementAt(1);

  final List<int> _crListVar = [25, 50, 75, 100, 200, 300];
  late int _crVar = _crListVar.first;

  final List<String> _itemTypes = ["coins", "gems", "armor", "shields", "weapons", "rings", "staves", "rods", "potions", "scrolls", "wands", "wondrous items"];
  List<Object?> _selectedItems = [];

  final List<String> _classTypes = ["Melee", "Tank", "Ranged", "Divine", "Druid", "Bard/Skald", "Monk", "Animal Companion", "Rogue/Slayer", "Arcane", "Spontaneous","Alchemist", "Witch", "Shaman", "Inquisitor", "Gunsligner"];
  List<Object?> _selectedClasses = [];

  final List<String> _gemsType1 = ["banded agate", "eye agate", "moss agate", "azurite", "blue quartz", "hematite", "lapis lazuli", "malachite", "obsidian", "rhodochrosite", "tiger eye turquoise", "irregular pearl"];
  final List<String> _gemsType2 = ["bloodstone", "carnelian", "chalcedony", "chrysoprase", "citrine", "iolite", "jasper", "moonstone", "onyx", "peridot", "rock crystal", "clear quartz", "sard", "sardonyx", "rose quartz", "smoky quartz", "star rose quartz", "zircon"];
  final List<String> _gemsType3 = ["amber", "amethyst", "chrysoberyl", "coral," "red garnet", "brown-green garnet", "jade", "jet", "jet li", "white pearl", "golden pearl", "pink pearl", "silver pearl", "red spinel", "red-brown spinel", "deep green spinel", "tourmaline"];
  final List<String> _gemsType4 = ["alexandrite", "aquamarine", "violet garnet", "black pearl", "deep blue spinel", "golden yellow topaz"];
  final List<String> _gemsType5 = ["emerald", "white opal", "black opal", "fire opal", "blue sapphire", "fiery yellow corundrum", "rich purple corundum", "blue star sapphire", "black star sapphire", "star ruby"];
  final List<String> _gemsType6 = ["green emerald", "blue-white diamond", "canary diamond", "pink diamond", "chocolate diamond", "blue diamond", "jacinth"];
  final List<int> _gemsValues = [4,4,1,2,4,10,4,4,10,2,4,100,4,4,100,2,4,1000];

  final List<int> _valueByCRSlow = [170,350,550,750,1000,1350,1750,2200,2850,3650,4650,6000,7750,10000,13000,16500,22000,28000,35000,44000,55000,69000];
  final List<int> _valueByCRMed = [260,550,800,1150,1550,2000,2600,3350,4250,5450,7000,9000,11600,15000,19500,25000,32000,41000,53000,67000,84000,104000];
  final List<int> _valueByCRFast = [400,800,1200,1700,2300,3000,3900,5000,6400,8200,10500,13500,17500,22000,29000,38000,48000,62000,79000,100000,125000,155000];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  List<DropdownMenuItem<int>> _ddm_int(List<int> a){
    return(a.map<DropdownMenuItem<int>>((int value) {
      return DropdownMenuItem<int>
        (value: value,
        child: Text(value.toString()),
      );
    }).toList());
  }

  List<DropdownMenuItem<String>> _ddm_string(List<String> a){
    return(a.map<DropdownMenuItem<String>>((String s) {
      return DropdownMenuItem<String>
        (value: s,
        child: Text(s),
      );
    }).toList());
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("Progression"),
                const SizedBox(width: 10.0),
                DropdownButton<String>(
                    value: _prog,
                    items: _ddm_string(_progression),
                    onChanged: (String? newString){
                      setState(() {
                        _prog = newString!;
                      });
                    }),
                const Text("Random List?"),
                const SizedBox(width: 10.0),
                DropdownButton<String>(
                    value: _rnd,
                    items: _ddm_string(_ynList),
                    onChanged: (String? newString){
                      setState(() {
                        _rnd = newString!;
                      });
                    }),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("Select Encounter Type"),
                const SizedBox(width: 10.0),
                DropdownButton<String>(
                    value: _et,
                    items: _ddm_string(_encType),
                    onChanged: (String? newString){
                      setState(() {
                         _et = newString!;
                      });
                    }),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("Select CR"),
                const SizedBox(width: 10.0),
                DropdownButton<int>(
                    value: _cr,
                    items: _ddm_int(_crList),
                    onChanged: (int? newInt){
                      setState(() {
                        _cr = newInt!;
                      });
                    }),
                TextButton(
                    child: const Text("% CR Variance"),
                  onPressed: (){
                      showDialog(
                          context: context,
                          builder: (context) {
                            return(AlertDialog(
                              title: const Text("% CR Variance Help"),
                              content: const Text("% CR Variance indicates the degree to which the treasure value will vary from the normal CR amount, distributed normally with a standard deviation of 1/3 the variance indicated"),
                              scrollable: true,
                              actions: <Widget>[
                                MaterialButton(
                                  child: const Text("OK"),
                                  color: Colors.grey[350],
                                  elevation: 8.0,

                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                )
                              ]


                            ));
                          },
                      );
                  },
                ),
                const SizedBox(width: 10.0),
                DropdownButton<int>(
                    value: _crVar,
                    items: _ddm_int(_crListVar),
                    onChanged: (int? newInt){
                      setState(() {
                        _crVar = newInt!;
                      });
                    }),
              ],
            ),
            MultiSelectDialogField(
                buttonText: Text("Treasure types to exclude"),
                items: _itemTypes.map((itemType) => MultiSelectItem(itemType, itemType)).toList(),
                initialValue: _selectedItems,
                listType: MultiSelectListType.CHIP,
                title: const Text("click on excluded types"),
                onConfirm: (itemValues) {
                  _selectedItems = itemValues;
                  print(_selectedItems);
                  setState((){});
              },
            ),
            const Text("class bias currently disabled"),
            /*
            MultiSelectDialogField(
              buttonText: Text("Role biases to include"),
              items: _classTypes.map((classType) => MultiSelectItem(classType, classType)).toList(),
              initialValue: _selectedClasses,
              listType: MultiSelectListType.CHIP,
              title: const Text("click on included classes"),
              onConfirm: (itemValues) {
                _selectedClasses = itemValues;
                print(_selectedClasses);
                setState((){});
              },
            ),*/
            //Text(_selectedItems.toString()),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,


        tooltip: 'Create List',
        //child: const Icon(Icons.attach_money_rounded),
        child: const Icon(Icons.vpn_key),
        //child: const Text("Create"),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
