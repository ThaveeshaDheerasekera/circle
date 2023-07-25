import 'package:circle/providers/posts_provider.dart';
import 'package:flutter/material.dart';

import 'package:circle/widget/home_screen_widgets/post_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SvgPicture.asset(
            'assets/logo/circle.svg',
            width: 45,
            height: 45,
            fit: BoxFit.cover,
          ),
        ),
      ),
      body: Consumer(builder: (context, ref, child) {
        final data = ref.watch(PostsProvider.postsListProvider);
        return data.when(
          data: (data) {
            return ListView.builder(
              itemCount: data.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                final post = data[index];
                return PostWidget(
                  index: index,
                  content:
                      post.content, // Pass the content from the Post object
                  image: post.image, // Pass the image URL from the Post object
                  commentsCount: post
                      .commentsCount, // Pass comments count from the Post object
                  likesCount:
                      post.likesCount, // Pass likes count from the Post object
                );
              },
            );
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          error: (error, stackTrace) {
            return Center(
              child: Text(error.toString()),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
