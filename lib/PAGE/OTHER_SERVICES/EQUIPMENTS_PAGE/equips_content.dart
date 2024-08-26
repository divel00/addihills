import 'package:addhills_app/PAGE/DOCUMENT_REQUEST/dr_register.dart';
import 'package:flutter/material.dart';
// import 'package:addhills_app/PAGE/DOCUMENT_REQUEST/doc_req_content.dart';
import 'package:addhills_app/PAGE/TOP_BUTTONS/top_navigationpop.dart';

class EquipsContent extends StatelessWidget {
  var height,width;
  String name,description,lastMod,CreatedOn,requirement,rules;
  int quantity;
  Map price;

  EquipsContent({
    required this.name,
    required this.description,
    required this.lastMod,
    required this.CreatedOn,
    required this.price,
    required this.requirement,
    required this.rules,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Builder(
        builder: (context) {
          return Container(
            color: Colors.black,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  height: height * 0.15,
                  width: width,
                  alignment: Alignment.topCenter,
                  child: TopNavigationpop(color: Colors.white,),
                ),
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        )
                      ),
                      height: height - (height * 0.15),
                      width: width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 30,
                              bottom: 15,
                            ),
                            child: Text(
                              'Equipments',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Divider(
                            indent: 50,
                            endIndent: 50,
                            color: Colors.black54
                          ),
                          Container(
                            height: (height * .64), width: width,
                            padding: EdgeInsets.only(left: 50, right: 50),
                            child: ListView(
                              padding: EdgeInsets.zero,
                              children: [
                                EquipReqContent(
                                  name: name, 
                                  description: description, 
                                  lastMod: lastMod, 
                                  CreatedOn: CreatedOn, 
                                  price: price, 
                                  requirement: requirement,
                                  rules: rules,
                                  quantity: quantity,
                                ),
                              ],
                            ),
                          ),
                          EquipReqButton(title: name,),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}

class EquipReqContent extends StatefulWidget {
  final String name, description, lastMod, CreatedOn, requirement, rules;
  int quantity;
  final Map<dynamic, dynamic> price;

  EquipReqContent({
    required this.name,
    required this.description,
    required this.lastMod,
    required this.CreatedOn,
    required this.price,
    required this.requirement,
    required this.rules,
    required this.quantity,
  });

  @override
  _EquipReqContentState createState() => _EquipReqContentState();
}

class _EquipReqContentState extends State<EquipReqContent> {
  Map<String, Map<String, int>> _nestedMap = {};

  @override
  void initState() {
    super.initState();
    _initializeNestedMap();
  }

  void _initializeNestedMap() {
    setState(() {
      _nestedMap = widget.price.map((key, value) {
        // Ensure the inner map is correctly typed
        var innerMap = (value as Map<dynamic, dynamic>).map((innerKey, innerValue) {
          return MapEntry(innerKey as String, (innerValue as num).toInt());
        });
        return MapEntry(key as String, innerMap);
      });
    });
  }

  String _formatNestedMapToSentence(Map<String, Map<String, int?>> nestedMap) {
  return nestedMap.entries
    .map((categoryEntry) {
      final category = categoryEntry.key;
      final items = categoryEntry.value;

      // Format each category with its items
      return '$category: Quantity = ' + items.entries
        .map((itemEntry) {
          final value = itemEntry.value;
          // If value is null, print "Free"; otherwise, print the value
          return value == null ? 'Free' : '${value}';
        })
        .join(' / ₱');
    })
    .join('\n');
}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topCenter,
          child: Text(
            widget.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 10),
          alignment: Alignment.topLeft,
          child: Text(
            'Description: \n${widget.description}\n\nItem Quantity: ${widget.quantity}\n\nRequirements: \n${widget.requirement}\n\nRules:\n${widget.rules}\n\nPrice:',
            style: TextStyle(fontSize: 15),
            textAlign: TextAlign.justify,
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            _formatNestedMapToSentence(_nestedMap),
            style: TextStyle(fontSize: 15),
          ),
        ),
      ],
    );
  }
}


class EquipReqButton extends StatelessWidget {
  //const DocReqButton({super.key,});
  String title;

  EquipReqButton({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 243, 109, 99),
          padding: EdgeInsets.only(left: 80, right: 80, top: 10, bottom: 10,),
        ),
        onPressed: (){
          // Navigator.push(
          //   context, MaterialPageRoute(builder: (BuildContext context) => DrRegister(title: title,)));
        },
        child: Text('Request', style: TextStyle(fontSize: 15, color: Colors.white),),
      ),
    );
  }
}