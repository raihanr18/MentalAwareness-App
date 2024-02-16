import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Page
import 'package:healman_mental_awareness/utils/next_page.dart';
import 'package:healman_mental_awareness/pages/admin/kelola_admin.dart';
import 'package:healman_mental_awareness/pages/admin/artikel_admin.dart';
import 'package:healman_mental_awareness/pages/admin/meditasi_admin.dart';
import 'package:healman_mental_awareness/controller/login_controller.dart';

class AdminPage extends StatelessWidget {
  AdminPage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isLargeScreen = width > 800;

    return Theme(
      data: ThemeData.light(),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleSpacing: 0,
          leading: isLargeScreen
              ? null
              : IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                ),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Admin Dashboard",
                  style: TextStyle(
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),
                ),
                if (isLargeScreen) Expanded(child: _navBarItems(context))
              ],
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: CircleAvatar(child: _ProfileIcon()),
            )
          ],
        ),
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: ListView.builder(
              itemCount: _cards.length,
              itemBuilder: (BuildContext context, int index) {
                if (_cards[index].title == 'Jumlah User') {
                  return FutureBuilder<int>(
                    future: fetchUserCount(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return _buildUserCardPlaceHolder();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return _buildUserCard(snapshot.data ?? 0);
                      }
                    },
                  );
                } else if (_cards[index].title == 'Jumlah Admin') {
                  return FutureBuilder<int>(
                    future: fetchAdminCount(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return _buildAdminCardPlaceHolder();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return _buildAdminCard(snapshot.data ?? 0);
                      }
                    },
                  );
                } else {
                  return _buildCard(_cards[index]);
                }
              },
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Text(
                    'Dashboard Admin Kontrol',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Poppins'),
                  ),
                ),
              ),
              for (String menuItem in _menuItems)
                ListTile(
                  title: Text(menuItem),
                  onTap: () {
                    // Navigate to the corresponding page here
                    switch (menuItem) {
                      case 'Musik Meditasi':
                        nextPage(context, const MeditasiAdmin());
                        break;
                      case 'Artikel':
                        nextPage(context, const ArtikelAdmin());
                        break;
                      case 'Kelola Admin':
                        nextPage(context, const KelolaAdmin());
                        break;
                      default:
                        break;
                    }
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserCard(int? userCount) {
    String displayText = userCount != null
        ? userCount.toString()
        : _cards.firstWhere((card) => card.title == 'Jumlah User').textCard;

    return Container(
      height: 136,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Jumlah User',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  displayText,
                  style: const TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8.0),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/user-trans.png"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdminCard(int? adminCount) {
    String displayText = adminCount != null
        ? adminCount.toString()
        : _cards.firstWhere((card) => card.title == 'Jumlah Admin').textCard;

    return Container(
      height: 136,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Jumlah Admin',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  displayText,
                  style: const TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8.0),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/admin.png"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(Card item) {
    return Container(
      height: 136,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  item.textCard,
                  style: const TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(item.image),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navBarItems(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _menuItems
            .map(
              (item) => InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 24.0, horizontal: 16),
                  child: Text(
                    item,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            )
            .toList(),
      );

  Future<int> fetchUserCount() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .where('role', isEqualTo: 'USER')
        .get();

    return snapshot.size;
  }

  Future<int> fetchAdminCount() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .where('role', isEqualTo: 'ADMIN')
        .get();

    return snapshot.size;
  }

  // Placeholder widget for shimmer effect
  Widget _buildUserCardPlaceHolder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 136,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE0E0E0)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 20.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      height: 20.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: 80.0,
                      height: 20.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Placeholder widget for shimmer effect
  Widget _buildAdminCardPlaceHolder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 136,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE0E0E0)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 20.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      height: 20.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: 80.0,
                      height: 20.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileIcon extends StatelessWidget {
  const _ProfileIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lc = context.watch<LoginController>();

    return CircleAvatar(
      backgroundImage: NetworkImage('${lc.imageUrl}'),
      radius: 19,
    );
  }
}

class Card {
  final String title;
  final String textCard;
  final String image;

  Card({required this.title, required this.textCard, required this.image});
}

final List<Card> _cards = [
  Card(
    title: "Jumlah User",
    textCard: "Jumlah User ....",
    image: "assets/user-trans.png",
  ),
  Card(
    title: "Jumlah Artikel",
    textCard: "20",
    image: "assets/article.png",
  ),
  Card(
    title: "Jumlah Admin",
    textCard: "20",
    image: "assets/admin.png",
  )
];

final List<String> _menuItems = <String>[
  'Musik Meditasi',
  'Artikel',
  'Kelola Admin'
];
