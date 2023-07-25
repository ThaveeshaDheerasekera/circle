import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({
    Key? key,
    required this.index,
    required this.content,
    required this.image,
    required this.commentsCount,
    required this.likesCount,
  }) : super(key: key);

  final int index;
  final String content;
  final String? image;
  final int commentsCount;
  final int likesCount;

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 0.75, color: Colors.grey.withOpacity(0.25)),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              'https://media.macphun.com/img/uploads/customer/how-to/579/15531840725c93b5489d84e9.43781620.jpg?q=85&w=1340',
              width: 45,
              height: 45,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              // color: Colors.blue,
              padding: const EdgeInsets.only(left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Thaveesha Dheerasekera',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ExpandableText(
                    widget.content,
                    expandText: 'show more',
                    collapseText: 'show less',
                    maxLines: 3,
                    linkColor: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(height: 8),
                  widget.image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            widget.image!,
                            fit: BoxFit.fitWidth,
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(Icons.comment_outlined),
                          ),
                          const SizedBox(width: 8),
                          Text(widget.commentsCount.toString())
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(Icons.favorite_outline_rounded),
                          ),
                          const SizedBox(width: 8),
                          Text(widget.commentsCount.toString())
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(Icons.share_rounded),
                          ),
                          const SizedBox(width: 8),
                          const Text('5')
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(Icons.bookmark_outline_rounded),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
