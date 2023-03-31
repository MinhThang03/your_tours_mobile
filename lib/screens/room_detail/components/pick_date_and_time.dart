import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePickerRow extends StatefulWidget {
  final ValueChanged<DateTime> onChangeStartDate;
  final ValueChanged<DateTime> onChangeEndDate;

  const DateTimePickerRow(
      {Key? key,
      required this.onChangeStartDate,
      required this.onChangeEndDate})
      : super(key: key);

  @override
  State<DateTimePickerRow> createState() => _DateTimePickerRowState();
}

class _DateTimePickerRowState extends State<DateTimePickerRow> {
  late DateTime _selectedDateTimeFrom;
  late DateTime _selectedDateTimeTo;
  final _dateFormat = DateFormat('dd/MM/yyyy');
  final _timeFormat = DateFormat('HH:mm');

  @override
  void initState() {
    super.initState();
    _selectedDateTimeFrom = DateTime.now();
    _selectedDateTimeTo = DateTime.now();
  }

  Future<void> _pickDateFrom() async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTimeFrom,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        _selectedDateTimeFrom = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          _selectedDateTimeFrom.hour,
          _selectedDateTimeFrom.minute,
        );
      });

      widget.onChangeStartDate(_selectedDateTimeFrom);
    }
  }

  Future<void> _pickDateTo() async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTimeTo,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        _selectedDateTimeTo = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          _selectedDateTimeTo.hour,
          _selectedDateTimeTo.minute,
        );
      });

      widget.onChangeEndDate(_selectedDateTimeTo);
    }
  }

  Future<void> _pickTime() async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDateTimeFrom),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedTime != null) {
      setState(() {
        _selectedDateTimeFrom = DateTime(
          _selectedDateTimeFrom.year,
          _selectedDateTimeFrom.month,
          _selectedDateTimeFrom.day,
          selectedTime.hour,
          selectedTime.minute,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: _pickDateFrom,
            child: AbsorbPointer(
              child: TextFormField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  labelText: "Nhận phòng",
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(
                  text: _dateFormat.format(_selectedDateTimeFrom),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: GestureDetector(
            onTap: _pickDateTo,
            child: AbsorbPointer(
              child: TextFormField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  labelText: "Trả phòng",
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(
                  text: _dateFormat.format(_selectedDateTimeTo),
                ),
              ),
            ),
          ),
        ),
        // Expanded(
        //   child: GestureDetector(
        //     onTap: _pickTime,
        //     child: AbsorbPointer(
        //       child: TextFormField(
        //         decoration: const InputDecoration(
        //           contentPadding: EdgeInsets.symmetric(horizontal: 20),
        //           labelText: "Trả phòng" ,
        //           border: OutlineInputBorder(),
        //         ),
        //         controller: TextEditingController(
        //           text: _timeFormat.format(_selectedDateTime),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
