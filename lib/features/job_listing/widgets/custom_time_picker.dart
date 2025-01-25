import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class CustomTimePickerBottomSheet extends StatefulWidget {
  final TimeOfDay initialTime;
  final ValueChanged<TimeOfDay> onTimeSelected;

  const CustomTimePickerBottomSheet({
    Key? key,
    required this.initialTime,
    required this.onTimeSelected,
  }) : super(key: key);

  @override
  State<CustomTimePickerBottomSheet> createState() =>
      _CustomTimePickerBottomSheetState();
}

class _CustomTimePickerBottomSheetState
    extends State<CustomTimePickerBottomSheet> {
  late TimeOfDay tempSelectedTime;

  @override
  void initState() {
    super.initState();
    tempSelectedTime = widget.initialTime;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF232526), Color(0xFF414345)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              height: 5,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.grey[500],
                borderRadius: BorderRadius.circular(2.5),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                TextField(
                  readOnly: true,
                  controller: TextEditingController(
                      text: tempSelectedTime.format(context)),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                  decoration: InputDecoration(
                    fillColor: Colors.black,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.tealAccent,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.tealAccent.withOpacity(0.5),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TimePickerSpinner(
                  initialTime: tempSelectedTime,
                  onTimeChanged: (newTime) {
                    setState(() {
                      tempSelectedTime = newTime;
                    });
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(color: Colors.grey[600], thickness: 1, height: 24),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent.withOpacity(0.8),
                    shadowColor: Colors.redAccent,
                    elevation: 4,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "CANCEL",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.onTimeSelected(tempSelectedTime);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.tealAccent,
                    shadowColor: Colors.tealAccent,
                    elevation: 4,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "OK",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Spinner and TimePickerSpinner classes remain the same as your original code.

class TimePickerSpinner extends StatelessWidget {
  final TimeOfDay initialTime;
  final ValueChanged<TimeOfDay> onTimeChanged;

  const TimePickerSpinner({
    Key? key,
    required this.initialTime,
    required this.onTimeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spinner(
          range: List.generate(24, (index) => index),
          selectedValue: initialTime.hour,
          onChanged: (value) {
            onTimeChanged(TimeOfDay(hour: value, minute: initialTime.minute));
          },
        ),
        const Text("  :  ",
            style: TextStyle(fontSize: 40, color: Colors.tealAccent)),
        Spinner(
          range: List.generate(60, (index) => index),
          selectedValue: initialTime.minute,
          onChanged: (value) {
            onTimeChanged(TimeOfDay(hour: initialTime.hour, minute: value));
          },
        ),
      ],
    );
  }
}

class Spinner extends StatelessWidget {
  final List<int> range;
  final int selectedValue;
  final ValueChanged<int> onChanged;

  const Spinner({
    Key? key,
    required this.range,
    required this.selectedValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 70,
      child: ListWheelScrollView(
        itemExtent: 50,
        physics: const FixedExtentScrollPhysics(),
        diameterRatio: 1.5,
        onSelectedItemChanged: onChanged,
        children: range
            .map(
              (value) => AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: value == selectedValue ? 38 : 30,
                  fontWeight: value == selectedValue
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: value == selectedValue
                      ? Colors.tealAccent
                      : Colors.grey[600],
                ),
                child: Center(
                  child: Text(value.toString().padLeft(2, '0')),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
