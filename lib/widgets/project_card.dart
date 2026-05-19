import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final List<String> tech;
  final String imageAsset;
  final String githubUrl;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.tech,
    required this.imageAsset,
    required this.githubUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: const Color(0xFF1A1F1A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: InkWell(
        onTap: () => _launchUrl(githubUrl),
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  imageAsset,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 140,
                    color: const Color(0xFF2A2F2A),
                    child:
                        const Icon(Icons.image, size: 60, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(description,
                  style: const TextStyle(fontSize: 14), maxLines: 3),
              const SizedBox(height: 12),
              Wrap(
                spacing: 6,
                children: tech
                    .map((t) =>
                        Chip(label: Text(t), backgroundColor: Colors.grey[800]))
                    .toList(),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton.icon(
                  onPressed: () => _launchUrl(githubUrl),
                  icon: const Icon(Icons.code, color: Color(0xFF42A5F5)),
                  label: const Text('Source Code'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }
}
