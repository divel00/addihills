import 'package:addhills_app/MODELS/equips.dart';
import 'package:addhills_app/PAGE/OTHER_SERVICES/EQUIPMENTS_PAGE/equips_content.dart';
import 'package:addhills_app/SERVICES/db_service.dart';
import 'package:flutter/material.dart';
import 'package:addhills_app/PAGE/TOP_BUTTONS/top_navigationpop.dart';

class EquipmentsPage extends StatefulWidget{
  @override
  State<EquipmentsPage> createState() => _EquipmentsPageState();
}

class _EquipmentsPageState extends State<EquipmentsPage> {
  static var height,width;

  @override
  Widget build(BuildContext context){
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
                          ListOfEquips(),
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




class ListOfEquips extends StatelessWidget {
  // const ListOfDoc({
  //   super.key,
  //   required this.height,
  //   required this.width,
  // });

  var height = _EquipmentsPageState.height;
  var width = _EquipmentsPageState.width;

  final DbService _dbService = DbService();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (height * .67), width: width,
      padding: EdgeInsets.only(left: 50, right: 50),
      child: StreamBuilder(
        stream: _dbService.getEquips(),
        builder: (context, snapshot) {
          List docs = snapshot.data?.docs?? [];
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: docs.length,
            itemBuilder: (context, index) {
              Equips docu = docs[index].data();
              return ListTile(
                title: Container(
                  //padding: EdgeInsets.only(top: 50),
                  //alignment: Alignment.topCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${docu.itemName}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                      Text('${docu.itemDescription}', style: TextStyle(fontSize: 15), maxLines: 3,overflow: TextOverflow.ellipsis,),
                      Text('see more...', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                      Divider(
                        color: Colors.black54
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                  context, MaterialPageRoute(builder: (BuildContext context) => EquipsContent(
                    name: '${docu.itemName}', 
                    description: '${docu.itemDescription}',
                    lastMod: '${docu.lastUpdatedOn}',
                    CreatedOn: '${docu.createdOn}',
                    requirement: '- ${docu.itemRequirements.join('\n- ')}',
                    price: docu.pricingTable,
                    rules: '- ${docu.rules.join('\n- ')}',
                    quantity: docu.itemQuantity,
                  )));
                },
              );
            },
          );
        }
      ),
    );
  }
}