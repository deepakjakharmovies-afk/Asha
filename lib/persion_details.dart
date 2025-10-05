import 'package:flutter/material.dart';

// --- Placeholder Constants (Colors) ---
// Define placeholder colors based on the XML
const Color bgColor = Color(0xFFF5F5F5); // bg
const Color pink700 = Colors.blue; // pink_700
const Color other400 = Color(0xFF26A69A); // other_400 (Teal/Cyan for avatar background)
const Color other100 = Color(0xFFB2DFDB); // other_100 (Light Teal/Cyan for subtext)
const Color mediumGrey = Color(0xFFC9C9C9); // Tint color for back icon
const Color white = Colors.white;

// --- Mock Data ---
class BeneficiaryData {
  final String name = "Laxmi Kumari";
  final String category = "Pregnant Woman (ANC)";
  final String beneficiaryId = "ID-9012 3456 7890";
  final String husbandName = "Ramesh Kumar";
  final String age = "28 Years";
  final String lmp = "2024-03-15"; // Last Menstrual Period
  final String edd = "2024-12-20"; // Estimated Delivery Date
  final String risk = "High Risk (Anemia)";
  final String village = "Naya Gaon";
  final String phone = "+91 98765 43210";
  final String asha = "Priya Sharma (99000 11000)";
}

// --- Custom Detail Row Widget (Replaces @layout/item_detail_row) ---
class DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const DetailRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: pink700 , size: 20),
          const SizedBox(width: 12),
          // Left side (Label)
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // Right side (Value)
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Main Screen Widget ---
class BeneficiaryProfileScreen extends StatelessWidget {
  const BeneficiaryProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = BeneficiaryData();

    // The Scaffold provides the visual structure, and the SingleChildScrollView
    // acts as the NestedScrollView/ScrollView.
    return Scaffold(
      backgroundColor: bgColor,
      // Prevents automatic top padding, handled manually in the header
      // body is wrapped in SingleChildScrollView (NestedScrollView)
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- Header Section (Gradient Background) ---
            _buildHeader(context, data),

            // --- Demographics & Identification Section ---
            _buildSectionTitle("Demographics & Identification"),
            _buildInfoCard(
              children: [
                DetailRow(
                    icon: Icons.fingerprint,
                    label: "Beneficiary ID",
                    value: data.beneficiaryId),
                const Divider(height: 1, thickness: 1, color: Colors.black12), // DividerLine
                DetailRow(
                    icon: Icons.person_2_outlined,
                    label: "Husband Name",
                    value: data.husbandName),
                const Divider(height: 1, thickness: 1, color: Colors.black12), // DividerLine
                DetailRow(
                    icon: Icons.calendar_month,
                    label: "Age",
                    value: data.age),
              ],
            ),

            // --- Clinical Data Section ---
            _buildSectionTitle("Antenatal Care Status (ANC)"),
            _buildInfoCard(
              children: [
                DetailRow(
                    icon: Icons.date_range,
                    label: "LMP Date",
                    value: data.lmp),
                const Divider(height: 1, thickness: 1, color: Colors.black12), // DividerLine
                DetailRow(
                    icon: Icons.baby_changing_station,
                    label: "Expected Delivery Date (EDD)",
                    value: data.edd),
                const Divider(height: 1, thickness: 1, color: Colors.black12), // DividerLine
                DetailRow(
                    icon: Icons.warning_amber_rounded,
                    label: "Risk Status",
                    value: data.risk),
              ],
            ),

            // --- Contact & Follow-up Section ---
            _buildSectionTitle("Contact & Follow-up"),
            _buildInfoCard(
              children: [
                DetailRow(
                    icon: Icons.location_on_outlined,
                    label: "Village/Address",
                    value: data.village),
                const Divider(height: 1, thickness: 1, color: Colors.black12), // DividerLine
                DetailRow(
                    icon: Icons.phone,
                    label: "Phone Number",
                    value: data.phone),
                const Divider(height: 1, thickness: 1, color: Colors.black12), // DividerLine
                DetailRow(
                    icon: Icons.medical_services_outlined,
                    label: "ASHA Contact",
                    value: data.asha),
              ],
            ),
            const SizedBox(height: 16), // Final spacing
          ],
        ),
      ),
    );
  }

  // Helper to build the gradient header
  Widget _buildHeader(BuildContext context, BeneficiaryData data) {
    // Replicates the LinearLayout with background gradient
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        // bg_gradient placeholder using pink/deep purple gradient
        gradient: LinearGradient(
          colors: [Color.fromARGB(255, 24, 35, 194), Color.fromARGB(255, 34, 69, 109)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Back Button
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, bottom: 8),
                child: InkWell(
                  onTap: () => Navigator.pop(context), // Go back
                  child: const Icon(Icons.arrow_back,
                      size: 30, color: mediumGrey), // ic_back placeholder
                ),
              ),
            ),
            // Inner content for avatar and text
            Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, bottom: 24, top: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Avatar (ShapeableImageView with full corner)
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: other400, // other_400 background
                      shape: BoxShape.circle, // ShapeAppearance.Material3.Corner.Full
                    ),
                    child: const Icon(
                      Icons.female, // ic_female placeholder
                      size: 60,
                      color: white, // tint="@color/white"
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Name (beneficiaryName)
                  Text(
                    data.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  // Category (beneficiaryCategory)
                  Text(
                    data.category,
                    style: TextStyle(
                      fontSize: 16,
                      color: other100, // other_100 tint
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper to build the section title
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: pink700, // pink_700
        ),
      ),
    );
  }

  // Helper to build the MaterialCardView containers
  Widget _buildInfoCard({required List<Widget> children}) {
    // Replicates MaterialCardView with elevated style, radius, and margin
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
      elevation: 5, // app:cardElevation="5dp"
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // app:cardCornerRadius="15dp"
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}
