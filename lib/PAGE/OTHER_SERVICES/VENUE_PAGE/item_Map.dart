import 'package:addhills_app/SERVICES/db_service.dart';
import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';


class Equipment {
  final String id;
  final String name;
  final int available; // Add available field

  Equipment({required this.id, required this.name, required this.available});

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'available': available, // Include available in JSON
  };

  static Equipment fromJson(Map<String, dynamic> json) {
    return Equipment(
      id: json['id'] as String,
      name: json['name'] as String,
      available: json['available'] as int, // Parse available from JSON
    );
  }
}


// Widget for Equipment Slot
class EquipmentSlot extends StatefulWidget {
  final Equipment? selectedEquipment;
  final int quantity;
  final int availableQuantity; // New parameter
  final ValueChanged<Equipment?> onEquipmentChanged;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onDelete;

  EquipmentSlot({
    required this.selectedEquipment,
    required this.quantity,
    required this.availableQuantity, // Accept available quantity
    required this.onEquipmentChanged,
    required this.onQuantityChanged,
    required this.onDelete,
  });

  @override
  _EquipmentSlotState createState() => _EquipmentSlotState();
}

class _EquipmentSlotState extends State<EquipmentSlot> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SizedBox(
            width: 110,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: Text(widget.selectedEquipment?.name ?? 'Select Equipment'),
            ),
          ),
        ),
        SizedBox(
          width: 80,
          child: InputQty.int(
            maxVal: widget.availableQuantity, // Set max value to available quantity
            initVal: widget.quantity,
            minVal: 0,
            steps: 1,
            onQtyChanged: (val) {
              widget.onQuantityChanged(val);
            },
            decoration: const QtyDecorationProps(
              qtyStyle: QtyStyle.classic,
            ),
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
class EquipmentInput extends StatefulWidget {
  final Function(String) onSelectionChanged; // Callback to pass data back
  EquipmentInput({required this.onSelectionChanged});

  @override
  _EquipmentInputState createState() => _EquipmentInputState();
}

class _EquipmentInputState extends State<EquipmentInput> {
  final DbService _dbService = DbService();
  List<Equipment> equipmentList = [];
  List<Map<String, dynamic>> slots = [];
  String selectedEquipmentsString = '';

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
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Equipment'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: equipmentList.length,
              itemBuilder: (context, index) {
                Equipment equipment = equipmentList[index];
                if (slots.any((slot) => slot['equipment'] == equipment)) return Container();

                return ListTile(
                  title: Text(equipment.name),
                  onTap: () {
                    Navigator.of(context).pop(equipment);
                  },
                );
              },
            ),
          ),
        );
      },
    ).then((selected) {
      if (selected != null && selected is Equipment) {
        setState(() {
          slots.add({'equipment': selected, 'quantity': 0, 'available': selected.available}); // Store available quantity
          _updateSelectedEquipmentsString();
        });
      }
    });
  }




  void updateSlot(int index, Equipment? equipment, int quantity) {
    setState(() {
      slots[index]['equipment'] = equipment;
      slots[index]['quantity'] = quantity;
      _updateSelectedEquipmentsString();
    });
  }

  void deleteSlot(int index) {
    setState(() {
      slots.removeAt(index);
      _updateSelectedEquipmentsString();
    });
  }

  void _updateSelectedEquipmentsString() {
    final List<String> selectedList = slots.map((slot) {
      return '${slot['equipment']?.name ?? 'None'} (${slot['quantity']})';
    }).toList();
    selectedEquipmentsString = selectedList.join(', ');
    widget.onSelectionChanged(selectedEquipmentsString); // Pass the updated string back
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: addSlot,
            icon: Icon(Icons.add, color: Colors.green, size: 30),
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
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: slots.length,
            itemBuilder: (context, index) {
              return EquipmentSlot(
                selectedEquipment: slots[index]['equipment'],
                quantity: slots[index]['quantity'],
                availableQuantity: slots[index]['available'], // Pass the available quantity
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
      ],
    );
  }
}
