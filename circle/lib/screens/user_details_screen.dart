import 'package:circle/repositories/auth_repository.dart';
import 'package:circle/widget/global_widgets/elevated_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Stack(
        children: [
          // Main container
          Container(
            padding: const EdgeInsets.only(bottom: 50),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 50,
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.5),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(2),
                                bottomRight: Radius.circular(2),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(right: 15),
                                    child: SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      child: Text('Profile Photo'),
                                    ),
                                  ),
                                ),
                                ElevatedButtonWidget(
                                  child: Text('Edit'),
                                  width: 50,
                                  height: 30,
                                  borderRadius: 2,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(2),
                              child: Image.asset(
                                'assets/images/thaveesha.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 50,
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.5),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(2),
                                bottomRight: Radius.circular(2),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(right: 15),
                                    child: SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      child: Text('Personal Information'),
                                    ),
                                  ),
                                ),
                                ElevatedButtonWidget(
                                  child: Text('Edit'),
                                  width: 50,
                                  height: 30,
                                  borderRadius: 2,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 5),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  attributeWidget(
                                      'Full Name', 'Thaveesha Dheerasekera'),
                                  const SizedBox(height: 5),
                                  attributeWidget('Userame', 'thaveesha'),
                                  const SizedBox(height: 5),
                                  attributeWidget(
                                      'Email', 'thaveesha.001@gmail.com'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Position the 'Logout' button
          // on the bottom of the page
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ElevatedButtonWidget(
              child: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              width: double.infinity,
              height: 50,
              borderRadius: 2,
              onPressed: () {
                Provider.of<AuthRepository>(context, listen: false).signOut();
              },
              //   () async {
              // // Future<void> _signOut() async {
              // await AuthRepository().signOut();
              // // }
              // },
            ),
          ),
        ],
      ),
    );
  }

  Row attributeWidget(String title, String content) {
    return Row(
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.w900)),
        Text(': ${content}')
      ],
    );
  }
}
