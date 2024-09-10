import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetailsScreen extends StatefulWidget {
  final String? title,
      urlToImage,
      author,
      publishedAt,
      description,
      content,
      url;
  const ArticleDetailsScreen({
    super.key,
    this.title,
    this.urlToImage,
    this.author,
    this.publishedAt,
    this.description,
    this.content,
    this.url,
  });

  @override
  State<ArticleDetailsScreen> createState() => _ArticleDetailsScreenState();
}

class _ArticleDetailsScreenState extends State<ArticleDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Article Details"),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Article Image
            Image.network(
              widget.urlToImage!,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    widget.title!,
                    style: const TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Published Date
                  Text(
                    widget.publishedAt!.substring(0, 10),
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Description
                  Text(
                    widget.description!,
                    style: const TextStyle(
                      fontSize: 18.0,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Content
                  Text(
                    widget.content!,
                    style: const TextStyle(
                      fontSize: 18.0,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Author
                  widget.author != null
                      ? Chip(
                          label: Text(
                            "Author: ${widget.author!}",
                            style: const TextStyle(fontSize: 14.0),
                          ),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(height: 16),

                  // News Source Card
                  Card(
                    margin: const EdgeInsets.all(0),
                    clipBehavior: Clip.antiAlias,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () async {
                        if (widget.url != null) {
                          await launchUrl(Uri.parse(widget.url!));
                        }
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.5),
                              BlendMode.darken,
                            ),
                            child: Image.network(
                              widget.urlToImage!,
                              fit: BoxFit.cover,
                              height: 150,
                              width: double.infinity,
                            ),
                          ),
                          const Text(
                            "News Source",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
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
    );
  }
}
