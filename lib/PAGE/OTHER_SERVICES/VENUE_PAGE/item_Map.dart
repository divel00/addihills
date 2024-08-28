import 'package:addhills_app/SERVICES/db_service.dart';
import 'package:flutter/material.dart';

// class ItemMap extends StatelessWidget {
//   // const ItemMap({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Container(
//                 width: 50,
//                 child: Text(
//                   textAlign: TextAlign.center,
//                   'Set',
//                   style: TextStyle(fontSize: 14),
//                 )
//               ),
//             SizedBox(
//               width: 8,
//             ),
//             Container(
//                 width: 100,
//                 child: Text(
//                   textAlign: TextAlign.center,
//                   'Quantity',
//                   style: TextStyle(fontSize: 14),
//                 )
//               ),
//             SizedBox(
//               width: 8,
//             ),
//             Container(
//               width: 50,
//               child: Text(
//                 textAlign: TextAlign.center,
//                 'Action',
//                 style: TextStyle(fontSize: 14),
//               ),
//             )
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 100,
//               child: TextFormField(
//                 //controller: updateListSetName[ index],
//                 style: TextStyle(fontSize: 15),
//                 decoration: InputDecoration(
//                   //hintText: 'What Event? e.g. For a birthday party',
//                   border: OutlineInputBorder(),
//                   isDense: true,
//                   //contentPadding: EdgeInsets.all(8),
//                 ),
//                 textInputAction: TextInputAction.done,
//               )
//             ),
//           ]
//         ),
//       ],
//     );
//   }
// }


// // Model for Equipment
// class Equipment {
//   final String id;
//   final String name;

//   Equipment(this.id, this.name);
// }

// // Widget for Equipment Slot
// class EquipmentSlot extends StatelessWidget {
//   final List<Equipment> equipmentList;
//   final Equipment? selectedEquipment;
//   final int quantity;
//   final ValueChanged<Equipment?> onEquipmentChanged;
//   final ValueChanged<int> onQuantityChanged;

//   EquipmentSlot({
//     required this.equipmentList,
//     required this.selectedEquipment,
//     required this.quantity,
//     required this.onEquipmentChanged,
//     required this.onQuantityChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: DropdownButton<Equipment>(
//             value: selectedEquipment,
//             onChanged: onEquipmentChanged,
//             hint: Text('Select Equipment'),
//             items: equipmentList.map((Equipment equipment) {
//               return DropdownMenuItem<Equipment>(
//                 value: equipment,
//                 child: Text(equipment.name),
//               );
//             }).toList(),
//           ),
//         ),
//         SizedBox(width: 16),
//         Expanded(
//           child: TextField(
//             keyboardType: TextInputType.number,
//             decoration: InputDecoration(labelText: 'Quantity'),
//             onChanged: (value) {
//               final intQuantity = int.tryParse(value) ?? 0;
//               onQuantityChanged(intQuantity);
//             },
//             controller: TextEditingController()..text = quantity.toString(),
//           ),
//         ),
//       ],
//     );
//   }
// }

// // Main Screen
// class EquipmentBorrowerSystem extends StatefulWidget {
//   @override
//   _EquipmentBorrowerSystemState createState() => _EquipmentBorrowerSystemState();
// }

// class _EquipmentBorrowerSystemState extends State<EquipmentBorrowerSystem> {
//   final List<Equipment> equipmentList = [
//     Equipment('1', 'Chair'),
//     Equipment('2', 'Table'),
//     Equipment('3', 'Laptop'),
//   ];

//   // Using a dynamic map to manage equipment slots
//   Map<int, Map<String, dynamic>> slots = {
//     0: {'equipment': null, 'quantity': 0},
//   };

//   int nextIndex = 1;

//   void addSlot() {
//     setState(() {
//       slots[nextIndex] = {'equipment': null, 'quantity': 0};
//       nextIndex++;
//     });
//   }

//   void updateSlot(int index, Equipment? equipment, int quantity) {
//     setState(() {
//       slots[index] = {'equipment': equipment, 'quantity': quantity};
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Equipment Borrower System')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 itemCount: slots.length,
//                 itemBuilder: (context, index) {
//                   final slot = slots[index]!;
//                   return EquipmentSlot(
//                     equipmentList: equipmentList,
//                     selectedEquipment: slot['equipment'],
//                     quantity: slot['quantity'],
//                     onEquipmentChanged: (equipment) {
//                       updateSlot(index, equipment, slot['quantity']);
//                     },
//                     onQuantityChanged: (quantity) {
//                       updateSlot(index, slot['equipment'], quantity);
//                     },
//                   );
//                 },
//               ),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: addSlot,
//               child: Text('Add Equipment Slot'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: EquipmentBorrowerSystem(),
//   ));
// }












// Model for Equipment
class Equipment {
  final String id;
  final String name;

  Equipment({required this.id, required this.name});

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };

  static Equipment fromJson(Map<String, dynamic> json) {
    return Equipment(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }
}

// Widget for Equipment Slot
class EquipmentSlot extends StatefulWidget {
  final List<Equipment> equipmentList;
  final Equipment? selectedEquipment;
  final int quantity;
  final ValueChanged<Equipment?> onEquipmentChanged;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onDelete;

  EquipmentSlot({
    required this.equipmentList,
    required this.selectedEquipment,
    required this.quantity,
    required this.onEquipmentChanged,
    required this.onQuantityChanged,
    required this.onDelete,
  });

  @override
  _EquipmentSlotState createState() => _EquipmentSlotState();
}

class _EquipmentSlotState extends State<EquipmentSlot> {
  late final TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController(text: widget.quantity.toString());
  }

  @override
  void didUpdateWidget(EquipmentSlot oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.quantity != widget.quantity) {
      _quantityController.text = widget.quantity.toString();
    }
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SizedBox(
            width: 110,
            child: DropdownButton<Equipment>(
              value: widget.selectedEquipment,
              onChanged: widget.onEquipmentChanged,
              hint: Text('Equipment'),
              items: widget.equipmentList.map((Equipment equipment) {
                return DropdownMenuItem<Equipment>(
                  value: equipment,
                  child: Text(equipment.name),
                );
              }).toList(),
            ),
          ),
        ),
        SizedBox(
          width: 50,
          child: TextField(
            controller: _quantityController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
              contentPadding: EdgeInsets.all(8),
            ),
            onChanged: (value) {
              final intQuantity = int.tryParse(value) ?? 0;
              widget.onQuantityChanged(intQuantity);
            },
          ),
        ),
        IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: widget.onDelete,
        ),
      ],
    );
  }
}


// Main Screen
class EquipmentBorrowerSystem extends StatefulWidget {
  @override
  _EquipmentBorrowerSystemState createState() => _EquipmentBorrowerSystemState();
}

class _EquipmentBorrowerSystemState extends State<EquipmentBorrowerSystem> {
  final DbService _dbService = DbService();
  List<Equipment> equipmentList = [];
  List<Map<String, dynamic>> slots = [
    {'equipment': null, 'quantity': 0},
  ];

  @override
  void initState() {
    super.initState();
    fetchEquipment();
  }

  void fetchEquipment() {
    _dbService.getEquipments().listen((equipments) {
      setState(() {
        equipmentList = equipments;
      });
    });
  }

  void addSlot() {
    setState(() {
      slots.add({'equipment': null, 'quantity': 0});
    });
  }

  void updateSlot(int index, Equipment? equipment, int quantity) {
    setState(() {
      slots[index]['equipment'] = equipment;
      slots[index]['quantity'] = quantity;
    });
  }

  void deleteSlot(int index) {
    setState(() {
      slots.removeAt(index);
    });
  }

  void submit() {
    List<Map<String, dynamic>> submittedData = slots.map((slot) {
      return {
        'equipment': (slot['equipment'] as Equipment?)?.name ?? 'None',
        'quantity': slot['quantity'],
      };
    }).toList();

    Navigator.of(context).pop(submittedData);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: addSlot,
            icon: Icon(Icons.add, color: Colors.green, size: 30,),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                'Set',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(width: 8),
            Container(
              child: Text(
                'Quantity',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(width: 8),
          ],
        ),
        Container(
          height: 250,
          child: ListView.builder(
            itemCount: slots.length,
            itemBuilder: (context, index) {
              return EquipmentSlot(
                equipmentList: equipmentList,
                selectedEquipment: slots[index]['equipment'],
                quantity: slots[index]['quantity'],
                onEquipmentChanged: (equipment) {
                  updateSlot(index, equipment, slots[index]['quantity']);
                },
                onQuantityChanged: (quantity) {
                  updateSlot(index, slots[index]['equipment'], quantity);
                },
                onDelete: () {
                  deleteSlot(index);
                },
              );
            },
          ),
        ),
        SizedBox(height: 30),
        ElevatedButton(
          onPressed: submit,
          child: Text('Save'),
        ),
      ],
    );
  }
}




