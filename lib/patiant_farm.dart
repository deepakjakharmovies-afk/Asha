import 'package:flutter/material.dart';

// --- Placeholder Constants (Colors) ---
// Define placeholder colors based on the XML
const Color bg = Color(0xFFF5F5F5); // light grey background
const Color pink700 = Color(0xFFC2185B); // Dark Pink
const Color other700 = Color(0xFF00796B); // Placeholder for `other_700` tint
const Color grey = Color(0xFF9E9E9E); // Medium grey
const Color mediumGrey = Color(0xFFC9C9C9); // Tint color for back icon
const Color white = Color(0xFFFFFFFF);

// Assuming selector_chip colors are defined, we'll use base colors for illustration
const Color chipMaleColor = Color(0xFF42A5F5); // Blue
const Color chipFemaleColor = Color(0xFFEF5350); // Red
const Color chipOtherColor = Color(0xFF9CCC65); // Green

class AddBeneficiaryScreen extends StatefulWidget {
  const AddBeneficiaryScreen({super.key});

  @override
  State<AddBeneficiaryScreen> createState() => _AddBeneficiaryScreenState();
}

class _AddBeneficiaryScreenState extends State<AddBeneficiaryScreen> {
  // State variables to manage dynamic UI elements
  bool _isMarried = false;
  bool _isPregnant = false;
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    // Scaffold provides the basic visual structure
    return Scaffold(
      backgroundColor: bg,
      // ScrollView is replaced by SingleChildScrollView
      body: SingleChildScrollView(
        // android:fillViewport="true" is the default behavior when content height exceeds viewport
        child: Padding(
          padding: const EdgeInsets.all(16.0), // android:padding="16dp"
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Top Bar (Back Button + Title)
              _buildTopBar(context),
              const SizedBox(height: 12),

              // Section Title
              const Text(
                "General Information",
                style: TextStyle(
                  color: pink700,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              // Form Card (androidx.cardview.widget.CardView)
              _buildFormCard(),

              // Submit Button
              const SizedBox(height: 16),
              _buildSubmitButton(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // --- Widget Builders ---

  Widget _buildTopBar(BuildContext context) {
    // Replicates the top horizontal LinearLayout with ImageView and TextView
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Back ImageView
          InkWell(
            onTap: () {
              Navigator.of(context).pop(); // Standard Flutter back navigation
            },
            child: const Icon(
              Icons.arrow_back, // ic_back placeholder
              color: mediumGrey,
              size: 30,
            ),
          ),
          const SizedBox(width: 8),

          // Title TextView
          Expanded(
            child: Text(
              "Add New Beneficiary",
              textAlign: TextAlign.center, // android:textAlignment="center"
              style: const TextStyle(
                color: pink700,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormCard() {
    return Card(
      elevation: 4, // app:cardElevation="4dp"
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // app:cardCornerRadius="12dp"
      ),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(12.0), // Inner padding, inferred for better look
        child: Column(
          children: <Widget>[
            // Name Input
            _buildTextFormField(
              hintText: "Name",
              icon: Icons.person, // ic_person placeholder
              iconColor: other700,
              marginTop: 6,
            ),
            // ID Input
            _buildTextFormField(
              hintText: "ID",
              icon: Icons.badge, // ic_badge placeholder
              keyboardType: TextInputType.number,
              maxLength: 12,
              marginTop: 8,
            ),
            // Age Input
            _buildTextFormField(
              hintText: "Age",
              icon: Icons.cake, // ic_cake placeholder
              keyboardType: TextInputType.number,
              marginTop: 8,
            ),
            // Married Switch
            _buildSwitch(
              label: "Are You Married?",
              value: _isMarried,
              onChanged: (val) {
                setState(() {
                  _isMarried = val;
                  // If not married, hide husband/pregnant fields immediately (Optional logic)
                  if (!val) {
                    _isPregnant = false;
                  }
                });
              },
              marginTop: 12,
            ),
            // Gender Title
            const Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Text(
                "Beneficiary Sex",
                style: TextStyle(
                  color: grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Gender Chips
            _buildGenderChipGroup(),

            // Father's Name Input
            _buildTextFormField(
              hintText: "Father's Name",
              icon: Icons.person,
              iconColor: other700,
              marginTop: 8,
            ),

            // Husband's Name Input (Hidden based on Married switch state)
            if (_isMarried)
              _buildTextFormField(
                hintText: "Husband's Name",
                icon: Icons.group, // ic_group placeholder
                iconColor: other700,
                marginTop: 8,
              ),

            // Pregnant Switch (Only visible for Female/Married)
            if (_isMarried && _selectedGender == "Female")
              _buildSwitch(
                label: "Pregnant ?",
                value: _isPregnant,
                onChanged: (val) {
                  setState(() => _isPregnant = val);
                },
                marginTop: 8,
              ),

            // How far along (Only visible if Pregnant is true)
            if (_isPregnant)
              _buildTextFormField(
                hintText: "How far along are you (Months)",
                icon: Icons.pregnant_woman, // ic_pregnant placeholder
                iconColor: other700,
                keyboardType: TextInputType.number,
                marginTop: 8,
              ),

            // Address Input
            _buildTextFormField(
              hintText: "Address",
              icon: Icons.home, // ic_home placeholder
              iconColor: other700,
              keyboardType: TextInputType.multiline,
              minLines: 3,
              marginTop: 8,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required String hintText,
    required IconData icon,
    Color iconColor = Colors.black45,
    TextInputType keyboardType = TextInputType.text,
    int? maxLength,
    int minLines = 1,
    required double marginTop,
  }) {
    // Replicates TextInputLayout and TextInputEditText styling
    return Padding(
      padding: EdgeInsets.only(top: marginTop),
      child: TextFormField(
        keyboardType: keyboardType,
        maxLength: maxLength,
        minLines: minLines,
        maxLines: (minLines > 1) ? null : 1, // Allow multiline if minLines > 1
        decoration: InputDecoration(
          labelText: hintText,
          prefixIcon: Icon(icon, color: iconColor),
          border: const OutlineInputBorder(),
          counterText: (maxLength != null) ? null : '', // Hide character counter unless maxLength is used
          alignLabelWithHint: minLines > 1, // Fix hint alignment for multiline
        ),
      ),
    );
  }

  Widget _buildSwitch({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
    required double marginTop,
  }) {
    // Replicates SwitchMaterial
    return Padding(
      padding: EdgeInsets.only(top: marginTop),
      child: SwitchListTile(
        title: Text(label),
        value: value,
        onChanged: onChanged,
        activeColor: pink700, // Customize switch color
        contentPadding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildGenderChipGroup() {
    // Replicates ChipGroup with singleSelection
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Wrap(
        spacing: 12.0, // app:chipSpacing="12dp"
        alignment: WrapAlignment.center, // android:gravity="center"
        children: <Widget>[
          _buildGenderChip("Male", Icons.male, chipMaleColor),
          _buildGenderChip("Female", Icons.female, chipFemaleColor),
          _buildGenderChip("Other", Icons.transgender, chipOtherColor),
        ],
      ),
    );
  }

  Widget _buildGenderChip(String label, IconData icon, Color color) {
    final isSelected = _selectedGender == label;
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? white : Colors.black87, // selector_chip_text
        ),
      ),
      selected: isSelected,
      onSelected: (bool selected) {
        setState(() {
          _selectedGender = selected ? label : null;
          // Logic for conditional fields based on gender
          if (label != "Female") {
            _isPregnant = false;
          }
        });
      },
      // Replicates chipBackgroundColor, chipIconTint, etc.
      selectedColor: color,
      backgroundColor: color.withOpacity(0.2),
      avatar: Icon(
        icon,
        color: isSelected ? white : color,
        size: 18,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: isSelected ? color : Colors.transparent),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
    );
  }

  Widget _buildSubmitButton() {
    // Replicates MaterialButton with custom styling
    return ElevatedButton.icon(
      onPressed: () {
        // Handle form submission
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Submitting Data...')),
        );
      },
      icon: const Icon(Icons.check_circle_outline, color: white), // round_check_24
      label: const Text(
        "Submit Data",
        style: TextStyle(color: white, fontSize: 18),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50), // layout_height="50dp"
        backgroundColor: pink700, // backgroundTint
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4), // default button corner radius
        ),
        elevation: 4,
      ),
    );
  }
}