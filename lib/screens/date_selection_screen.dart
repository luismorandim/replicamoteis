import 'package:flutter/material.dart';
import '../widgets/calendar_widget.dart';

class DateSelectionScreen extends StatefulWidget {
  @override
  _DateSelectionScreenState createState() => _DateSelectionScreenState();
}

class _DateSelectionScreenState extends State<DateSelectionScreen> {
  String selectedOption = "Pernoite";
  DateTime? selectedDate;
  DateTime? selectedEndDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildOptionSelector(),
          Expanded(
            child: CalendarWidget(
              selectedOption: selectedOption,
              selectedDate: selectedDate,
              selectedEndDate: selectedEndDate,
              onDateSelected: (date, endDate) {
                setState(() {
                  selectedDate = date;
                  selectedEndDate = endDate;
                });
              },
            ),
          ),
          if (_shouldShowConfirmButton()) _buildConfirmButton(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        "Programação",
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      leading: IconButton(
        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildOptionSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildOption("Pernoite", "para uma noite\n incrível"),
          _buildOption("Day-use", "para passar o dia\n"),
          _buildOption("Diárias", "para ficar um ou\n mais dias"),
        ],
      ),
    );
  }

  Widget _buildOption(String title, String description) {
    bool isSelected = selectedOption == title;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              selectedOption = title;
              selectedDate = null;
              selectedEndDate = null;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: isSelected ? Colors.red : Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                  color: isSelected ? Colors.red : Colors.grey,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(title, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(description, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  bool _shouldShowConfirmButton() {
    if (selectedOption == "Diárias") {
      return selectedDate != null && selectedEndDate != null;
    }
    return selectedDate != null;
  }

  Widget _buildConfirmButton() {
    return GestureDetector(
      onTap: () {
        if (selectedDate != null) {
          String selectedDatesText;
          if (selectedOption == "Diárias" && selectedEndDate != null) {
            selectedDatesText = "${_formatDate(selectedDate!)} - ${_formatDate(selectedEndDate!)}";
          } else {
            selectedDatesText = _formatDate(selectedDate!);
          }
          Navigator.pop(context, selectedDatesText);
        }
      },
      child: Container(
        width: double.infinity,
        color: Colors.red,
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: const Center(
          child: Text(
            "Confirmar",
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    const monthNames = [
      "Jan", "Fev", "Mar", "Abr", "Mai", "Jun",
      "Jul", "Ago", "Set", "Out", "Nov", "Dez"
    ];
    return "${date.day} ${monthNames[date.month - 1]}";
  }
}
