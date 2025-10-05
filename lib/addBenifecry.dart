import 'package:flutter/material.dart';

// --- Placeholder Colors and Icons (You should define these in your theme or assets) ---
const Color pink50 = Color(0xFFFCE4EC);   // Light Pink (AppBar Background)
const Color pink700 = Color(0xFFC2185B);  // Dark Pink (Title/Text/Button Color)
const Color white = Color(0xFFFFFFFF);

// Placeholder Icons (Replace with your custom assets if needed)
const IconData iconMedical = Icons.medical_services;
const IconData iconHome = Icons.home;
const IconData iconPerson = Icons.person;
const IconData iconCalendar = Icons.calendar_month;
const IconData iconMale = Icons.male;
const IconData iconFemale = Icons.female;
const IconData iconOther = Icons.transgender;
const IconData iconCheck = Icons.check_circle;

class AshaDataEntryScreen extends StatefulWidget {
  const AshaDataEntryScreen({super.key});

  @override
  State<AshaDataEntryScreen> createState() => _AshaDataEntryScreenState();
}

class _AshaDataEntryScreenState extends State<AshaDataEntryScreen> {
  // State variables for form controls
  String? _selectedSex;
  double _ratingValue = 1.0;

  @override
  Widget build(BuildContext context) {
    // CoordinatorLayout + MaterialToolbar is directly mapped to Scaffold + AppBar
    return Scaffold(
      appBar: AppBar(
        // Replicates MaterialToolbar properties
        title: const Text("ASHA Data Entry"),
        centerTitle: true,
        backgroundColor: pink50,
        titleTextStyle: const TextStyle(
          color: pink700,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        // The scroll|enterAlways flag is standard in Flutter's AppBar behavior
      ),
      // ScrollView is replaced by SingleChildScrollView
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Outer Padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // 1. Item Details Section
              _buildSectionTitle("Item Details"),
              const SizedBox(height: 8),
              _buildCardSection(
                children: <Widget>[
                  _buildTextFormField(
                    hintText: "Widget Name",
                    icon: iconMedical,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 10),
                  _buildTextFormField(
                    hintText: "Household ID",
                    icon: iconHome,
                    keyboardType: TextInputType.text,
                  ),
                ],
              ),
              // --- Separator ---
              const SizedBox(height: 20),

              // 2. Beneficiary Details Section
              _buildSectionTitle("Beneficiary Details"),
              const SizedBox(height: 8),
              _buildCardSection(
                children: <Widget>[
                  _buildTextFormField(
                    hintText: "Beneficiary Name",
                    icon: iconPerson,
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 10),
                  _buildTextFormField(
                    hintText: "Beneficiary Age",
                    icon: Icons.access_time, // No icon specified in XML, using a placeholder
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 12),
                  const Text("Beneficiary Sex", style: TextStyle(fontSize: 15)),
                  const SizedBox(height: 8),
                  _buildSexChipGroup(),
                ],
              ),
              // --- Separator ---
              const SizedBox(height: 20),

              // 3. Distribution & Follow-up Section
              _buildSectionTitle("Distribution & Follow-up"),
              const SizedBox(height: 8),
              _buildCardSection(
                children: <Widget>[
                  _buildDateFormField(hintText: "Distribution Date"),
                  const SizedBox(height: 10),
                  _buildDateFormField(hintText: "Follow-up Date"),
                  const SizedBox(height: 12),
                  _buildSwitch("Widget Handed Over"),
                  _buildSwitch("Widget Used Correctly"),
                ],
              ),
              // --- Separator ---
              const SizedBox(height: 20),

              // 4. Observed Outcome & Notes Section
              _buildSectionTitle("Observed Outcome & Notes"),
              const SizedBox(height: 8),
              _buildCardSection(
                children: <Widget>[
                  const Text("Observed Outcome", style: TextStyle(fontSize: 15)),
                  _buildRatingSlider(),
                  const SizedBox(height: 12),
                  _buildNotesTextFormField(),
                ],
              ),
              // --- Separator ---
              const SizedBox(height: 24),

              // 5. Submit Button
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  // --- Reusable Widgets and Methods ---

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: pink700,
      ),
    );
  }

  Widget _buildCardSection({required List<Widget> children}) {
    // Replicates CardView with cardCornerRadius and cardElevation
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required String hintText,
    required IconData icon,
    required TextInputType keyboardType,
  }) {
    // Replicates TextInputLayout and TextInputEditText
    return TextFormField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: hintText,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
      ),
    );
  }

  Widget _buildDateFormField({required String hintText}) {
    // Replicates non-focusable/clickable TextInputEditText for date picking
    return TextFormField(
      readOnly: true, // android:focusable="false" android:clickable="true"
      onTap: () async {
        // Placeholder for Date Picker logic
        await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2050),
        );
      },
      decoration: InputDecoration(
        labelText: hintText,
        prefixIcon: const Icon(iconCalendar),
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
      ),
    );
  }

  Widget _buildSexChipGroup() {
    // Replicates ChipGroup with singleSelection and individual Chips
    return Wrap(
      spacing: 8.0, // app:chipSpacing="8dp"
      children: <Widget>[
        _buildSexChip("Male", iconMale),
        _buildSexChip("Female", iconFemale),
        _buildSexChip("Other", iconOther),
      ],
    );
  }

  Widget _buildSexChip(String label, IconData icon) {
    // Replicates Chip with choice style
    final isSelected = _selectedSex == label;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      // Replicate chipIcon and chipIconTint
      avatar: Icon(icon, color: isSelected ? white : pink700, size: 18),
      selectedColor: pink700,
      backgroundColor: pink50,
      labelStyle: TextStyle(
        color: isSelected ? white : Colors.black87,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      onSelected: (bool selected) {
        setState(() {
          _selectedSex = selected ? label : null;
        });
      },
    );
  }

  Widget _buildSwitch(String label) {
    // Replicates SwitchMaterial
    bool value = false; // Placeholder state
    return SwitchListTile(
      title: Text(label),
      value: value,
      onChanged: (bool newValue) {
        setState(() {
          // Update the specific switch's state here
          value = newValue;
        });
      },
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildRatingSlider() {
    // Replicates Slider with valueFrom, valueTo, stepSize, and labelBehavior="visible"
    return Slider(
      value: _ratingValue,
      min: 1,
      max: 5,
      divisions: 4, // 1, 2, 3, 4, 5
      label: _ratingValue.round().toString(),
      onChanged: (double value) {
        setState(() {
          _ratingValue = value;
        });
      },
      activeColor: pink700,
    );
  }

  Widget _buildNotesTextFormField() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      minLines: 3, // android:minLines="3"
      maxLines: null,
      decoration: const InputDecoration(
        labelText: "Additional Notes",
        border: OutlineInputBorder(),
        alignLabelWithHint: true, // Aligns hint text to the top for multiline
      ),
    );
  }

  Widget _buildSubmitButton() {
    // Replicates MaterialButton with custom styling
    return ElevatedButton.icon(
      onPressed: () {
        // Submission logic here
        print("Data Submitted!");
      },
      icon: const Icon(iconCheck, color: white, size: 24), // round_check_24
      label: const Text(
        "Submit Data",
        style: TextStyle(fontSize: 18, color: white),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 55), // layout_width="match_parent", layout_height="55dp"
        backgroundColor: pink700, // android:backgroundTint="@color/pink_700"
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 4,
      ),
    );
  }
}