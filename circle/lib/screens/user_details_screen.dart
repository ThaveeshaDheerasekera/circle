import 'package:circle/repositories/auth_repository.dart';
import 'package:circle/widget/global_widgets/elevated_button_widget.dart';
import 'package:circle/widget/global_widgets/title_widget.dart';
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
    return Consumer<AuthRepository>(
      builder: (context, user, child) => Padding(
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
                      TitleWidget(
                        title: 'Avatar',
                        actions: [
                          ElevatedButtonWidget(
                            child: Text('Edit'),
                            width: 50,
                            height: 30,
                            borderRadius: 2,
                            onPressed: null,
                          ),
                        ],
                        child: Container(
                          height: 150,
                          width: 150,
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
                      ),
                      const SizedBox(height: 15),
                      TitleWidget(
                        title: 'Personal Information',
                        actions: [
                          ElevatedButtonWidget(
                            child: Text('Edit'),
                            width: 50,
                            height: 30,
                            borderRadius: 2,
                            onPressed: null,
                          ),
                        ],
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 5),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                attributeWidget(
                                    'User ID', user.currentUSer?.uid ?? ''),
                                const SizedBox(height: 5),
                                attributeWidget('Name',
                                    user.currentUSer?.displayName ?? ''),
                                const SizedBox(height: 5),
                                attributeWidget(
                                    'Email', user.currentUSer?.email ?? ''),
                              ],
                            ),
                          ),
                        ),
                      )
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
                  user.clearMessage();
                  user.signOut();
                },
              ),
            ),
          ],
        ),
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
