import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/form_select_item.dart';

class FormMultiChoiceDialog extends StatefulWidget {
  final List<FormSelectItem> values;
  final List<int> selectedValues;
  final Function onSelectionChanged;

  const FormMultiChoiceDialog(
      {Key key,
      @required this.values,
      this.selectedValues,
      this.onSelectionChanged})
      : super(key: key);

  @override
  _FormMultiChoiceDialogState createState() => _FormMultiChoiceDialogState();
}

class _FormMultiChoiceDialogState extends State<FormMultiChoiceDialog> {
  List<int> _selectedValues;

  @override
  void initState() {
    super.initState();
    _selectedValues =
        widget.selectedValues.length > 0 ? widget.selectedValues : [];
  }

  _buildChoiceList() {
    return widget.values
        .map((item) => Container(
              padding: const EdgeInsets.all(2.0),
              child: ChoiceChip(
                label: Text(item.label),
                selected: _selectedValues.contains(item.value),
                onSelected: (selected) {
                  if (selected) {
                    setState(() {
                      _selectedValues.add(item.value);
                    });
                  } else {
                    setState(() {
                      _selectedValues.remove(item.value);
                    });
                  }
                  widget.onSelectionChanged(_selectedValues);
                },
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
