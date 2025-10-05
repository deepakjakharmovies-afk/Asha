import 'package:finishedapp/searchpage.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // Add this package to pubspec.yaml

// Define some placeholder colors based on the XML
const Color bg = Color(0xFFF5F5F5); // light grey
const Color white = Color(0xFFFFFFFF);
const Color pink400 = Colors.blue; // A shade of pink
const Color pink700 = Colors.lightBlue ;// A darker shade of pink
const Color onSurface = Color(0xFF212121); // Dark grey/black for text
const Color grey = Color(0xFF9E9E9E); // Medium grey

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(viewportFraction: 0.95);
  final int _numPages = 3; // Placeholder for number of pages in ViewPager

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The background color from the ScrollView
      backgroundColor: bg,
      body: SingleChildScrollView(
        // ScrollView is converted to SingleChildScrollView
        child: Column(
          children: <Widget>[
            // The top gradient background and app bar section
            _buildAppBarSection(),

            // Section below the 'Add Beneficiary' box and ViewPager
            _buildMainContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBarSection() {
    return Stack(
      children: <Widget>[
        // Background Gradient (View with background, positioned by constraints)
        Container(
          height: 350, // Approximate height to cover area up to below topaddlayout
          decoration: const BoxDecoration(
            // Placeholder for @drawable/bg_gradient
            gradient: LinearGradient(
              colors: [pink700, pink400],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),

        // Content on top of the gradient
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Toolbar (Title and Internet Connection Icon)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // toolbarTitle
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16, 18, 16, 16),
                      child: Text(
                        "Hi, \nUser",
                        style: TextStyle(
                          color: white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // internetConnection ImageView
                    Padding(
                      padding: const EdgeInsets.only(top: 20, right: 20),
                      child: Icon(
                        Icons.cloud_off, // ic_cloud_off
                        color: pink400,
                        size: 50,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 10),

                // topaddlayout (LinearLayout with MaterialButton and TextView)
                _buildAddAndSearchSection(),
                
                const SizedBox(height: 14),

                // topContainer (LinearLayout with ViewPager2)
                _buildViewPagerSection(),
              ],
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildAddAndSearchSection() {
    // This is equivalent to topaddlayout (a LinearLayout inside ConstraintLayout)
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: white, // Placeholder for @drawable/search_input_bg
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          // btnSubmit (MaterialButton)
          ElevatedButton.icon(
            onPressed:(){ 
              Navigator.of(context).pushNamed("/data_entry/");
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: Colors.transparent, // Background controlled by decoration
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.zero,
            ).copyWith(
              // Placeholder for @drawable/bg_button
              backgroundColor: MaterialStateProperty.all(pink700),
            ),
            icon: const Icon(Icons.person_add_alt_1, color: white), // ic_add_person
            label: const Text(
              "Add Beneficiary Entry",
              style: TextStyle(color: white, fontSize: 16),
            ),
          ),

          const SizedBox(height: 12),

          // searchInput (TextView acting as a search bar)
          GestureDetector(
            onTap: () {
              // Navigate to the SearchPage when the widget is clicked
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: grey), // Placeholder for ic_black_corner border
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  
                  const Padding(
                    padding: EdgeInsets.only(left: 12.0, right: 8.0),
                    child: Icon(Icons.search, color: pink400), // ic_search
                  ),
                  Text(
                    "Search Beneficiary Id",
                    style: TextStyle(
                      color: grey, // textColorHint
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewPagerSection() {
    // topContainer contains the ViewPager section
    return Column(
      children: <Widget>[
        // ViewPager2 (viewPager)
        SizedBox(
          height: 90,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _numPages,
            itemBuilder: (context, index) {
              // Placeholder for individual pages in ViewPager2
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: pink400.withOpacity(0.7), // Just a placeholder card color
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text('Card ${index + 1}', style: const TextStyle(color: white)),
              );
            },
          ),
        ),

        const SizedBox(height: 4),

        // DotsIndicator (dots_indicator)
        SmoothPageIndicator(
          controller: _pageController,
          count: _numPages,
          effect: const WormEffect(
            dotHeight: 8.0,
            dotWidth: 8.0,
            activeDotColor: white, // selectedDotColor
            dotColor: onSurface, // dotsColor (black)
          ),
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    // This is the LinearLayout below topContainer and contains the rest of the content
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Upcoming Reminders Title
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              "Upcoming Reminders",
              style: TextStyle(
                color: pink700,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Reminder Card (androidx.cardview.widget.CardView)
          _buildReminderCard(),

          // Quick Actions (Visibility is gone in XML, so this section is also hidden/omitted by default)
          // ...

          // Recent Visits Title Row
          _buildRecentVisitsHeader(),

          // Recent Visits ListView (listViewWorkers)
          // Since ListView inside a SingleChildScrollView needs to be wrapped in a specific way,
          // a Column is often preferred with dynamically generated children for fixed content.
          // For a dynamically loading list, you'd use a ListView.builder with a specific height (like 600dp in XML).
          // Here, I'll use a Column and show two dummy list items to mimic the XML comments.
          _buildRecentVisitItem("Radhika Singh", "Last Visit: 2 hours ago"),
          _buildRecentVisitItem("Vijay Kumar", "Last Visit: Yesterday"),
          _buildRecentVisitItem("Sunita Devi", "Last Visit: 3 days ago"),

          // Extra space at the bottom (to account for the large ListView height)
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildReminderCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(top: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Reminder 1
            _buildReminderItem(
              icon: Icons.vaccines, // ic_vaccines
              title: "Vaccination Due: Baby Riya",
              subtitle: "Tomorrow, 10:00 AM",
            ),

            // Divider (View)
            Container(
              height: 1,
              margin: const EdgeInsets.only(top: 12),
              color: grey.withOpacity(0.5),
            ),

            // Reminder 2
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: _buildReminderItem(
                icon: Icons.pregnant_woman, // ic_pregnant (using an approximate icon)
                title: "ANC Check-up: Ms. Sharma",
                subtitle: "Today, 2:30 PM",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReminderItem({required IconData icon, required String title, required String subtitle}) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          size: 28,
          color: pink700,
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                color: onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(color: grey),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentVisitsHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Recent Visits",
            style: TextStyle(
              color: pink700,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "View All",
            style: TextStyle(
              color: pink700,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
  
  // A function to mimic one item from the ListView or the commented-out CardViews
  Widget _buildRecentVisitItem(String name, String lastVisit) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(top: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            // CircleImageView equivalent
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: pink700.withOpacity(0.1), // Placeholder for backgroundTint/tint
              ),
              child: const Icon(Icons.person, color: pink700, size: 30), // ic_person
            ),
            
            const SizedBox(width: 12),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: const TextStyle(
                      color: onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    lastVisit,
                    style: const TextStyle(color: grey),
                  ),
                ],
              ),
            ),
            
            Icon(
              Icons.arrow_forward_ios, // ic_arrow_forward (using a common alternative)
              color: grey,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}