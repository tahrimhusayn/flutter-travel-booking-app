import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void main() {
  runApp(const TravelEaseApp());
}

/* ===================== APP THEME ===================== */
class TravelEaseApp extends StatelessWidget {
  const TravelEaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF00695C),
        fontFamily: 'Plus Jakarta Sans',
      ),
      home: const MainNavigation(),
    );
  }
}

/* ===================== GLOBAL CART ===================== */
class CartModel {
  String title;
  String subtitle;
  int members;
  int price;
  CartModel(
      {required this.title,
        required this.subtitle,
        this.members = 1,
        required this.price});
}

List<CartModel> cart = [];

class HistoryModel {
  String title;
  String feedback;
  double rating;
  String moodEmoji;
  HistoryModel(
      {required this.title,
        required this.feedback,
        required this.rating,
        required this.moodEmoji});
}

List<HistoryModel> historyList = [];

/* ===================== MAIN NAVIGATION ===================== */
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const ExploreToursPage(),
    const HistoryPage(),
    const CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            backgroundColor: Colors.white.withOpacity(0.8),
            currentIndex: _currentIndex,
            onTap: (i) => setState(() => _currentIndex = i),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.teal,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'Explore'),
              BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
            ],
          ),
        ),
      ),
    );
  }
}

/* ===================== 1. HOME PAGE ===================== */
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<String> quotes = const [
    "Travel far, travel wide.",
    "Adventure is out there.",
    "Collect memories, not things.",
    "The world is yours to explore.",
  ];

  @override
  Widget build(BuildContext context) {
    String quote = quotes[Random().nextInt(quotes.length)];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 140,
            floating: true,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              title: Row(
                children: const [
                  Icon(Icons.flight_takeoff, color: Colors.teal),
                  SizedBox(width: 10),
                  Text("Travello",
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                          fontSize: 22)),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _buildHeroBanner(),
                  const SizedBox(height: 20),
                  _buildQuoteCard(quote),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ExploreToursPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                    ),
                    child: const Text("Explore Tours",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 30),
                  _buildNewsletterSection(context),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        image: const DecorationImage(
          image: AssetImage("assets/appimages/home_banner2.jpeg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black.withOpacity(0.3), Colors.transparent],
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: const Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            "Discover New Worlds\nAdventure Awaits You",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
    );
  }

  Widget _buildQuoteCard(String quote) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(Icons.format_quote, color: Colors.teal, size: 30),
          const SizedBox(width: 10),
          Expanded(
              child: Text(quote,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }

  Widget _buildNewsletterSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.teal.shade50, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          const Text("Subscribe to our Newsletter",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              hintText: "Enter your email",
              prefixIcon: const Icon(Icons.email, color: Colors.teal),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Subscribed successfully! 🎉"),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text("Subscribe"),
          ),
        ],
      ),
    );
  }
}

/* ===================== 2. EXPLORE PAGE ===================== */
class ExploreToursPage extends StatefulWidget {
  const ExploreToursPage({super.key});

  @override
  State<ExploreToursPage> createState() => _ExploreToursPageState();
}

class _ExploreToursPageState extends State<ExploreToursPage> {
  final TextEditingController searchController = TextEditingController();

  // Updated tour data
  final Map<String, List<Map<String, dynamic>>> toursData = {
    "Featured": [
      {"title": "Paris Getaway", "price": 1200, "image": "assets/appimages/paris.jpg"},
      {"title": "Dubai Explorer", "price": 950, "image": "assets/appimages/dubai.png"},
      {"title": "Swiss Alps Adventure", "price": 1100, "image": "assets/appimages/swiss.jpg"},
      {"title": "Maldives Escape", "price": 1400, "image": "assets/appimages/maldives.png"},
    ],
    "Packages": [
      {"title": "Turkey Delight", "price": 900, "image": "assets/appimages/turkey.jpg"},
      {"title": "Thailand Adventure", "price": 850, "image": "assets/appimages/thailand.jpg"},
      {"title": "Italy Wonders", "price": 1250, "image": "assets/appimages/italy.jpg"},
      {"title": "Japan Discovery", "price": 1300, "image": "assets/appimages/japan.jpg"},
    ],
    "Special Offers": [
      {"title": "Bali Paradise", "price": 850, "image": "assets/appimages/bali.jpg"},
      {"title": "Singapore Highlights", "price": 950, "image": "assets/appimages/singapore.jpg"},
      {"title": "London Tour", "price": 1200, "image": "assets/appimages/london.jpg"},
      {"title": "Egypt Pyramids", "price": 1000, "image": "assets/appimages/egypt.jpg"},
    ],
    "Recommended": [
      {"title": "Korea Journey", "price": 1100, "image": "assets/appimages/korea.jpg"},
      {"title": "Australia Trip", "price": 1250, "image": "assets/appimages/australia.png"},
      {"title": "Greece Escape", "price": 1150, "image": "assets/appimages/greece.jpeg"},
      {"title": "Spain Adventure", "price": 1050, "image": "assets/appimages/spain.jpg"},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black), // Black back button
        title: const Text("Explore", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          _buildSearchBar(),
          const SizedBox(height: 20),
          ...toursData.keys.map((section) => _buildSection(section)).toList(),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: "Search your destination...",
        prefixIcon: const Icon(Icons.search, color: Colors.teal),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none),
        filled: true,
        fillColor: Colors.grey.shade200,
      ),
    );
  }

  Widget _buildSection(String title) {
    final List<Map<String, dynamic>> tours = toursData[title]!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Text("See All", style: TextStyle(color: Colors.teal)),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 240,
          child: Row(
            children: List.generate(tours.length, (index) {
              final tour = tours[index];
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TourDetailsPage(
                          title: tour["title"],
                          price: tour["price"],
                          image: tour["image"],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage(tour["image"]),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(20)),
                          ),
                          child: Column(
                            children: [
                              Text(tour["title"],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              Text("\$${tour["price"]}",
                                  style: const TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 5),
                              ElevatedButton(
                                onPressed: () {
                                  cart.add(CartModel(
                                      title: tour["title"],
                                      subtitle: "$title Tour",
                                      price: tour["price"]));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "${tour["title"]} added to cart!")),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.teal,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                ),
                                child: const Text("Add to Cart",
                                    style: TextStyle(fontSize: 12)),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

/* ===================== 3. TOUR DETAILS ===================== */
class TourDetailsPage extends StatefulWidget {
  final String title;
  final int price;
  final String image;

  const TourDetailsPage(
      {super.key, required this.title, required this.price, required this.image});

  @override
  State<TourDetailsPage> createState() => _TourDetailsPageState();
}

class _TourDetailsPageState extends State<TourDetailsPage> {
  double userRating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(widget.image), fit: BoxFit.cover),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: CircleAvatar(
                backgroundColor: Colors.white24,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.title,
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                          Text("Tour Details",
                              style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.teal.shade50,
                            borderRadius: BorderRadius.circular(15)),
                        child: Text("\$${widget.price}",
                            style: const TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text("Description",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 5),
                  Text(
                    "Experience ${widget.title}. Enjoy your personalized tour with amazing activities and sights.",
                    style: TextStyle(color: Colors.grey.shade600, height: 1.5),
                  ),
                  const SizedBox(height: 10),
                  Text("Rate this tour",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  RatingBar.builder(
                    initialRating: userRating,
                    minRating: 0,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 30,
                    itemBuilder: (context, _) =>
                    const Icon(Icons.star, color: Colors.amber),
                    onRatingUpdate: (rating) {
                      setState(() {
                        userRating = rating;
                      });
                    },
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          onPressed: () {
                            cart.add(CartModel(
                                title: widget.title,
                                subtitle: "Tour Details",
                                price: widget.price));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      "${widget.title} added to cart! Go book now.")),
                            );
                          },
                          child: const Text("Book Journey Now",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

/* ===================== 4. CART PAGE ===================== */
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Removed the back button
        title: const Text("Cart" , style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (cart.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text("Your cart is empty",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ...cart.map((item) => ListTile(
                title: Text(item.title),
                subtitle: Text(item.subtitle),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("\$${item.price}"),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            cart.remove(item);
                          });
                        },
                        icon: const Icon(Icons.delete, color: Colors.red))
                  ],
                ),
              )),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: cart.isEmpty
                            ? null
                            : () {
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text(
                                    "Clear Cart Confirmation"),
                                content: const Text(
                                    "Are you sure you want to remove all items from cart?"),
                                actions: [
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context),
                                      child: const Text("Cancel")),
                                  TextButton(
                                      onPressed: () {
                                        setState(() {
                                          cart.clear();
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Confirm")),
                                ],
                              ));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent),
                        child: const Text("Clear Cart")),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: cart.isEmpty
                            ? null
                            : () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                  const CheckoutPage()));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal),
                        child: const Text("Checkout")),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

/* ===================== 5. CHECKOUT PAGE ===================== */
class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController contactC = TextEditingController();
  final TextEditingController addressC = TextEditingController();
  final TextEditingController postalC = TextEditingController();
  final TextEditingController requirementsC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double fieldWidth = MediaQuery.of(context).size.width * 0.85;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        title: const Text("Checkout" , style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)
                ]),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text("Complete Your Booking",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 20),
                  _buildTextField("Name", nameC, width: fieldWidth, icon: Icons.person),
                  _buildTextField("Email", emailC, width: fieldWidth, icon: Icons.email),
                  _buildTextField("Contact", contactC, width: fieldWidth, icon: Icons.phone),
                  _buildTextField("Address", addressC, width: fieldWidth, icon: Icons.home),
                  _buildTextField("Postal Code", postalC, width: fieldWidth, icon: Icons.local_post_office),
                  // _buildTextField("Additional Requirements", requirementsC,
                  //     maxLines: 3, width: fieldWidth, icon: Icons.note),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity, // Full width button
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          cart.clear(); // Empty the cart
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Booking completed successfully! 🎉"),
                            ),
                          );
                          // Navigate to HomePage and remove all previous pages
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => const MainNavigation()),
                                (route) => false,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: const Text("Complete Order",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController c,
      {int maxLines = 1, double? width, IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        width: width ?? double.infinity,
        child: TextFormField(
          controller: c,
          maxLines: maxLines,
          validator: (v) => v == null || v.isEmpty ? "Required" : null,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: icon != null ? Icon(icon, color: Colors.teal) : null,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none),
            filled: true,
            fillColor: Colors.grey.shade200,
          ),
        ),
      ),
    );
  }
}


/* ===================== 6. HISTORY PAGE ===================== */
class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    if (historyList.isEmpty) {
      historyList.addAll([
        HistoryModel(
            title: "Paris Getaway",
            feedback: "Amazing experience! Loved it 😍",
            rating: 4.5,
            moodEmoji: "😍"),
        HistoryModel(
            title: "Swiss Alps Adventure",
            feedback: "Breathtaking views 🏔️",
            rating: 5,
            moodEmoji: "🏔️"),
        HistoryModel(
            title: "Tokyo Exploration",
            feedback: "Loved the culture 🍣",
            rating: 4,
            moodEmoji: "🍣"),
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: BackButton(color: Colors.white),
        title:
        const Text("Feedback History", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: historyList.length,
        itemBuilder: (context, index) {
          HistoryModel h = historyList[index];
          return Card(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            margin: const EdgeInsets.only(bottom: 15),
            child: ListTile(
              title: Text(h.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: List.generate(
                        5,
                            (i) => Icon(Icons.star,
                            color: i < h.rating.round()
                                ? Colors.amber
                                : Colors.grey,
                            size: 16)),
                  ),
                  Text("${h.feedback} ${h.moodEmoji}"),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() {
                    historyList.removeAt(index);
                  });
                },
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80), // ✅ above navbar
        child: FloatingActionButton(
          backgroundColor: Colors.teal,
          child: const Icon(Icons.add),
          onPressed: () {
            _showAddHistoryDialog(context);
          },
        ),
      ),

    );
  }

  void _showAddHistoryDialog(BuildContext context) {
    final TextEditingController nameC = TextEditingController();
    final TextEditingController feedbackC = TextEditingController();
    double rating = 0;
    String mood = "😊";
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text("Add Feedback"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: nameC, decoration: const InputDecoration(hintText: "Tour Name")),
                TextField(controller: feedbackC, decoration: const InputDecoration(hintText: "Feedback")),
                const SizedBox(height: 10),
                RatingBar.builder(
                  initialRating: rating,
                  minRating: 0,
                  itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (r) { rating = r; },
                  itemSize: 25,
                ),
                const SizedBox(height: 10),
                DropdownButton<String>(
                  value: mood,
                  items: const ["😊","😍","😎","🤩","😢","😡"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (v) { if(v!=null) mood=v; },
                )
              ],
            ),
            actions: [
              TextButton(onPressed: (){Navigator.pop(context);}, child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    setState(() {
                      historyList.add(HistoryModel(title: nameC.text, feedback: feedbackC.text, rating: rating, moodEmoji: mood));
                    });
                    Navigator.pop(context);
                  },
                  child: const Text("Add"))
            ],
          );
        });
  }
}
