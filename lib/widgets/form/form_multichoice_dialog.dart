import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormMultiChoiceDialog extends StatefulWidget {
  final List<String> values;
  final List<String> selectedValues;
  final Function(List<String>) onSelectionChanged;

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
  List<String> _selectedValues = List();
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
                label: Text(item),
                selected: _selectedValues.contains(item),
                onSelected: (selected) {
                  setState(() {
                    _selectedValues.contains(item)
                        ? _selectedValues.remove(item)
                        : _selectedValues.add(item);
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
