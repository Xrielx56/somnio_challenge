import 'package:flutter/material.dart';

class PostBlogCardWidget extends StatelessWidget {
  const PostBlogCardWidget({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        print('navigation action in card');
      },
      child: Card(
        elevation: 1,
        margin: const EdgeInsets.only(bottom: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(width: 0.1, color: Colors.grey),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 15),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                    constraints: const BoxConstraints(minHeight: 20),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade900,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                      child: Text(
                        'Post type name',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      height: 1.3,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        Text(
                          'Read more',
                          style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        const SizedBox(width: 5),
                        Icon(
                          Icons.arrow_forward,
                          size: 20,
                          color: Colors.blue.shade700,
                          weight: 20,
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/somnio_software.jpg',
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
