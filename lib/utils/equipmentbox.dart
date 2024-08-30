import 'package:addhills_app/PAGE/OTHER_SERVICES/VENUE_PAGE/item_Map.dart';
import 'package:flutter/material.dart';

class EquipmentBox extends StatefulWidget {
  final TextEditingController equipmentController;

  EquipmentBox({
    required this.equipmentController,
  });

  @override
  State<EquipmentBox> createState() => _EquipmentBoxState();
}

class _EquipmentBoxState extends State<EquipmentBox> {
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: widget.equipmentController,
        decoration: InputDecoration(
          labelText: 'Add Equipment',
          border: OutlineInputBorder(),
        ),
        readOnly: true,
        onTap: () {
          _handleEquipmentSelection(context,widget.equipmentController);
        }, // Make it read-only if you don’t want user to edit directly
      );
  }

  // Function to show the dialog and handle equipment selection
Future<List<Map<String, dynamic>>?> _showEquipmentBorrowerDialog({
  required List<Map<String, dynamic>> initialData,
  required BuildContext context,
}) {
  return showDialog<List<Map<String, dynamic>>>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          width: double.maxFinite,
          height: 400,
          child: EquipmentBorrowerSystem(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close if no data
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}

// Function to handle equipment selection and update TextEditingController
void _handleEquipmentSelection(BuildContext context, TextEditingController controller) async {
  final List<Map<String, dynamic>>? result = await _showEquipmentBorrowerDialog(
    initialData: controller.text
        .split(', ')
        .map((item) {
          final parts = item.split(' (');
          final equipment = parts[0];
          final quantity = int.tryParse(parts[0].replaceAll(')', '')) ?? 0;
          return {
            'equipment': equipment,
            'quantity': quantity,
          };
        })
        .toList(),
    context: context,
  );

  if (result != null) {
    final List<String> additionalEquipments = result.map((item) {
      return '${item['equipment']} (${item['quantity']})';
    }).toList();

    // Update the TextEditingController with the formatted list of strings
    controller.text = additionalEquipments.join(', ');
  }
}


}