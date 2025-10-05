import "package:flutter/material.dart";


Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, top: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.pink.shade700,
        ),
      ),
    );
  }


  Widget buildCreativeCard({required List<Widget> children}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: children,
        ),
      ),
    );
  }

  Widget buildTextFormField(TextEditingController controller, String labelText, IconData icon, {TextInputType? keyboardType, int maxLines = 1, bool obscureText = false, Widget? suffixIcon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon, color: Colors.pink.shade400),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.pink, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $labelText';
          }
          return null;
        },
      ),
    );
  }

  Widget buildGenderSelection({
  required String? selectedSex, 
  required Function(String?) onSexSelected, // Callback for state update
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Beneficiary Sex',
          style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          children: [
            // Pass the current state and the setter function down
            buildGenderChip('Male', Icons.male, Colors.blue, selectedSex: selectedSex, onSelected: onSexSelected),
            buildGenderChip('Female', Icons.female, Colors.pink, selectedSex: selectedSex, onSelected: onSexSelected),
            buildGenderChip('Other', Icons.transgender, Colors.purple, selectedSex: selectedSex, onSelected: onSexSelected),
          ],
        ),
      ],
    ),
  ); 
}

/// Simple curved header used on the login page. Provides title and subtitle.
Widget buildLoginHeader({required String title, required String subtitle}) {
  return Container(
    height: 200,
    decoration: const BoxDecoration(
      gradient: LinearGradient(colors: [Color(0xFF4A00E0), Color(0xFF8E2DE2)]),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 24.0, top: 56.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 16)),
        ],
      ),
    ),
  );
}

/// Generic language/dropdown field builder.
Widget buildLanguageDropdownField<T>({
  required IconData prefixIcon,
  required String labelText,
  required T? value,
  required List<DropdownMenuItem<T>> items,
  required ValueChanged<T?> onChanged,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: InputDecorator(
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefixIcon, color: Colors.pink.shade400),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          items: items,
          onChanged: onChanged,
        ),
      ),
    ),
  );
}

Widget buildGenderChip(
  String label, 
  IconData icon, 
  Color color, 
  {
    required String? selectedSex, // The current selected value from the stateful widget
    required Function(String?) onSelected, // The function to update the state
  }
) {
  bool isSelected = selectedSex == label;
  return ChoiceChip(
    label: Text(label),
    selected: isSelected,
    onSelected: (selected) {
      // Call the external state update function
      onSelected(selected ? label : null);
    },
    avatar: Icon(icon, color: isSelected ? Colors.white : color),
    selectedColor: color.withOpacity(0.8),
    backgroundColor: color.withOpacity(0.2),
    labelStyle: TextStyle(color: isSelected ? Colors.white : color),
    elevation: isSelected ? 4 : 1,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  );
}

  Widget buildDatePickerField({required String label, required DateTime? selectedDate, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(Icons.calendar_today_outlined, color: Colors.pink.shade400),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.pink, width: 2),
            ),
          ),
          child: Text(
            selectedDate == null ? 'Select Date' : '${selectedDate.toLocal()}'.split(' ')[0],
            style: TextStyle(fontSize: 16, color: selectedDate == null ? Colors.grey.shade700 : Colors.black),
          ),
        ),
      ),
    );
  }

  Widget buildSwitchTile(String title, bool value, Function(bool?) onChanged) {
    return SwitchListTile(
      title: Text(title, style: TextStyle(color: Colors.grey.shade800, fontSize: 16)),
      value: value,
      onChanged: onChanged,
      activeThumbColor: Colors.pink,
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget buildRatingSelector(String label, double rating, Function(double) onRatingUpdate) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 16, color: Colors.grey.shade800)),
          const SizedBox(height: 8),
          Slider(
            value: rating,
            min: 1,
            max: 5,
            divisions: 4,
            label: rating.round().toString(),
            activeColor: Colors.pink,
            inactiveColor: Colors.pink.shade100,
            onChanged: onRatingUpdate,
          ),
        ],
      ),
    );
  }

  /// Primary action button used across the app.
  /// Full-width, rounded gradient button with an icon and text.
  Widget buildPrimaryButton({
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: Material(
          color: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pink.shade600, Colors.pink.shade400],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: onPressed,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(icon, color: Colors.white),
                    const SizedBox(width: 12),
                    Text(
                      text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
