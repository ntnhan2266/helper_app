import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/form_select_item.dart';

class FormMultiChoiceDialog extends StatefulWidget {
  final List<FormSelectItem> values;
  final List<int> selectedValues;
  final Function(List<int>) onSelectionChanged;

  const FormMultiChoiceDialog(
      {Key key,
      @required this.values,
      this.selectedValues,
      this.onSelectionChanged})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FormMultiChoiceDialogState();
  }
}

class _FormMultiChoiceDialogState extends State<FormMultiChoiceDialog> {
  List<int> _selectedValues = List();
  @override
  void initState() {
    super.initState();
    _selectedValues = widget.selectedValues ?? List();
  }

  _buildChoiceList() {
    return widget.values
        .map((item) => Container(
              padding: const EdgeInsets.all(2.0),
              child: ChoiceChip(
                label: Text(item.label),
                selected: _selectedValues.contains(item),
                onSelected: (selected) {
                  setState(() {
                    _selectedValues.contains(item)
                        ? _selectedValues.remove(item)
                        : _selectedValues.add(item.value);
                    widget.onSelectionChanged(_selectedValues);
                  });
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
