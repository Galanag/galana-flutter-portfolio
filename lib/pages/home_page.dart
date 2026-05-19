import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio_app/widgets/project_card.dart';
import 'package:portfolio_app/widgets/skill_chip.dart';
import 'package:portfolio_app/widgets/timeline_item.dart';
import 'package:portfolio_app/widgets/footer.dart';
import 'package:portfolio_app/widgets/animated_counter.dart';
import 'package:portfolio_app/widgets/service_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToSection(String sectionId) {
    final context = this.context;
    // Simple scroll: find the widget by GlobalKey – but for brevity,
    // we use the fact that each section has a unique key.
    // I'll assign keys in the builder.
    // Better: use a key map.
    // Let's implement properly:
    switch (sectionId) {
      case 'about':
        _scrollController.animateTo(
          _aboutKey.currentContext!.findRenderObject()!.paintBounds.top,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        break;
      case 'skills':
        _scrollController.animateTo(
          _skillsKey.currentContext!.findRenderObject()!.paintBounds.top,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        break;
      case 'projects':
        _scrollController.animateTo(
          _projectsKey.currentContext!.findRenderObject()!.paintBounds.top,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        break;
      case 'experience':
        _scrollController.animateTo(
          _experienceKey.currentContext!.findRenderObject()!.paintBounds.top,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        break;
      case 'contact':
        _scrollController.animateTo(
          _contactKey.currentContext!.findRenderObject()!.paintBounds.top,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        break;
    }
  }

  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portfolio',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        actions: [
          _navButton('About', () => _scrollToSection('about')),
          _navButton('Skills', () => _scrollToSection('skills')),
          _navButton('Projects', () => _scrollToSection('projects')),
          _navButton('Experience', () => _scrollToSection('experience')),
          _navButton('Contact', () => _scrollToSection('contact')),
        ],
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // Hero Section (full width)
          SliverToBoxAdapter(child: _buildHeroSection(context)),
          SliverToBoxAdapter(child: const SizedBox(height: 40)),
          // Stats row
          SliverToBoxAdapter(child: _buildStatsRow()),
          SliverToBoxAdapter(child: const SizedBox(height: 60)),
          // About Section
          SliverToBoxAdapter(
            child: _buildSection(
              key: _aboutKey,
              id: 'about',
              title: 'About Me',
              child: _buildAboutContent(context),
            ),
          ),
          SliverToBoxAdapter(child: const SizedBox(height: 60)),
          // Services / What I Do
          SliverToBoxAdapter(
            child: _buildSection(
              key: _servicesKey,
              id: 'services',
              title: 'What I Do',
              child: _buildServicesGrid(),
            ),
          ),
          SliverToBoxAdapter(child: const SizedBox(height: 60)),
          // Skills Section
          SliverToBoxAdapter(
            child: _buildSection(
              key: _skillsKey,
              id: 'skills',
              title: 'Technical Arsenal',
              child: _buildAdvancedSkills(),
            ),
          ),
          SliverToBoxAdapter(child: const SizedBox(height: 60)),
          // Projects Section
          SliverToBoxAdapter(
            child: _buildSection(
              key: _projectsKey,
              id: 'projects',
              title: 'Featured Projects',
              child: _buildProjectsGrid(),
            ),
          ),
          SliverToBoxAdapter(child: const SizedBox(height: 60)),
          // Experience & Education
          SliverToBoxAdapter(
            child: _buildSection(
              key: _experienceKey,
              id: 'experience',
              title: 'Journey',
              child: _buildTimeline(),
            ),
          ),
          SliverToBoxAdapter(child: const SizedBox(height: 60)),
          // Contact Section
          SliverToBoxAdapter(
            child: _buildSection(
              key: _contactKey,
              id: 'contact',
              title: 'Let’s Work Together',
              child: _buildContactForm(),
            ),
          ),
          SliverToBoxAdapter(child: const Footer()),
        ],
      ),
    );
  }

  Widget _navButton(String label, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(label, style: const TextStyle(fontSize: 16)),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF0A0F0A),
            const Color(0xFF1A2E1A),
            const Color(0xFF0A0F0A),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInUp(
              child: Hero(
                tag: 'profile',
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF42A5F5).withOpacity(0.3),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 85,
                    backgroundImage:
                        const AssetImage('assets/images/profile.png'),
                    onBackgroundImageError: (_, __) =>
                        const Icon(Icons.person, size: 85),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            FadeInUp(
              delay: const Duration(milliseconds: 200),
              child: Text(
                'Galanag',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 56,
                      letterSpacing: 2,
                      foreground: Paint()
                        ..shader = const LinearGradient(
                          colors: [Color(0xFF42A5F5), Color(0xFF4CAF50)],
                        ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                    ),
              ),
            ),
            const SizedBox(height: 12),
            FadeInUp(
              delay: const Duration(milliseconds: 400),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF42A5F5)),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Text(
                  'Flutter Developer · UI/UX Designer · Backend Architect',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: const Color(0xFF42A5F5),
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            FadeInUp(
              delay: const Duration(milliseconds: 600),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Building cross‑platform apps with Flutter | Backend: Firebase, Node.js, Laravel, MongoDB, PostgreSQL\n'
                  'Crafting pixel‑perfect designs with 5+ years of Figma expertise',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 40),
            FadeInUp(
              delay: const Duration(milliseconds: 800),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _launchUrl('https://github.com/Galanag'),
                    icon: const FaIcon(FontAwesomeIcons.github),
                    label: const Text('GitHub', style: TextStyle(fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 14),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 20),
                  OutlinedButton.icon(
                    onPressed: () => _scrollToSection('contact'),
                    icon: const FaIcon(FontAwesomeIcons.paperPlane),
                    label:
                        const Text('Hire Me', style: TextStyle(fontSize: 16)),
                    style: OutlinedButton.styleFrom(
                      side:
                          const BorderSide(color: Color(0xFF4CAF50), width: 2),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 14),
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

  Widget _buildStatsRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _statItem('3+', 'Years Experience'),
          _statItem('10+', 'Projects Shipped'),
          _statItem('5+', 'Years UX/UI'),
          _statItem('∞', 'Coffee Cups'),
        ],
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Column(
      children: [
        AnimatedCounter(
          value: value == '3+'
              ? 3
              : (value == '10+' ? 10 : (value == '5+' ? 5 : 999)),
          textStyle: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Color(0xFF42A5F5)),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }

  Widget _buildAboutContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'I’m a Computer Engineering graduate with a deep passion for crafting high‑performance, beautiful mobile apps using Flutter. '
                'Over the last 3 years, I’ve delivered 10+ production‑grade apps, collaborating with startups and agencies worldwide.',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(height: 1.5),
              ),
              const SizedBox(height: 24),
              const Text(
                '✨ Core strengths: clean architecture, Riverpod/BLoC, custom animations, REST/GraphQL.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              const Text(
                '⚙️ Backend: Firebase suite, Node.js (Express), Laravel, MongoDB, PostgreSQL.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              const Text(
                '🎨 Design: Figma (advanced prototyping), Adobe XD, user research, design systems.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => _launchUrl('assets/resume.pdf'),
                icon: const Icon(Icons.download),
                label: const Text('Download Resume'),
              ),
            ],
          ),
        ),
        const SizedBox(width: 40),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color(0xFF1A2E1A), const Color(0xFF0A0F0A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: const Color(0xFF4CAF50), width: 1),
            ),
            child: Column(
              children: [
                const FaIcon(FontAwesomeIcons.figma,
                    size: 52, color: Color(0xFF4CAF50)),
                const SizedBox(height: 16),
                Text(
                  '5+ years UX/UI Design',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                const Text(
                  'I don’t just code – I design. Every project starts with wireframes, high‑fidelity prototypes, and user testing.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildServicesGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      children: [
        const ServiceCard(
          icon: FontAwesomeIcons.mobileScreen,
          title: 'Mobile Development',
          description:
              'Native-quality iOS & Android apps with Flutter, smooth animations, and offline support.',
        ),
        const ServiceCard(
          icon: FontAwesomeIcons.cloud,
          title: 'Backend Integration',
          description:
              'Firebase, Node.js, Laravel – RESTful APIs, real‑time data, authentication, and cloud functions.',
        ),
        const ServiceCard(
          icon: FontAwesomeIcons.penRuler,
          title: 'UX/UI Design',
          description:
              'End‑to‑end design process in Figma: user flows, wireframes, prototypes, and design systems.',
        ),
      ],
    );
  }

  Widget _buildAdvancedSkills() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Frontend & Mobile',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          children: [
            'Flutter',
            'Dart',
            'Riverpod',
            'BLoC',
            'GetX',
            'REST API',
            'GraphQL',
            'WebSockets'
          ].map((s) => SkillChip(label: s)).toList(),
        ),
        const SizedBox(height: 32),
        const Text('Backend & Databases',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          children: [
            'Firebase',
            'Node.js',
            'Express',
            'Laravel',
            'MongoDB',
            'PostgreSQL',
            'MySQL',
            'Redis'
          ].map((s) => SkillChip(label: s)).toList(),
        ),
        const SizedBox(height: 32),
        const Text('Design & Tools',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          children: [
            'Figma',
            'Adobe XD',
            'Photoshop',
            'Git',
            'GitHub Actions',
            'Jira',
            'Postman'
          ].map((s) => SkillChip(label: s)).toList(),
        ),
      ],
    );
  }

  Widget _buildProjectsGrid() {
    final projects = [
      ProjectCard(
        title: 'UrbanCart – E‑Commerce',
        description:
            'Complete shopping app with Firebase Auth, Firestore, real‑time inventory, and Stripe payments.',
        tech: ['Flutter', 'Firebase', 'Stripe'],
        imageAsset: 'assets/images/project1.png',
        githubUrl: 'https://github.com/Galanag/ecommerce_app',
      ),
      ProjectCard(
        title: 'Chatty – Social Platform',
        description:
            'Real‑time messaging, stories, and post feed using Node.js + Socket.io and MongoDB.',
        tech: ['Flutter', 'Node.js', 'MongoDB', 'Socket.io'],
        imageAsset: 'assets/images/project2.png',
        githubUrl: 'https://github.com/Galanag/social_clone',
      ),
      ProjectCard(
        title: 'FitSync Tracker',
        description:
            'Workout & nutrition tracker with offline SQLite, sync with PostgreSQL backend (Laravel API).',
        tech: ['Flutter', 'Laravel', 'PostgreSQL', 'SQLite'],
        imageAsset: 'assets/images/project3.png',
        githubUrl: 'https://github.com/Galanag/fitness_tracker',
      ),
      ProjectCard(
        title: 'Portfolio 2026',
        description:
            'This very website – responsive, animated, deployed to GitHub Pages.',
        tech: ['Flutter Web', 'GitHub Pages', 'Custom Animations'],
        imageAsset: 'assets/images/project4.png',
        githubUrl: 'https://github.com/Galanag/portfolio',
      ),
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: 1.1,
      ),
      itemCount: projects.length,
      itemBuilder: (_, i) => projects[i],
    );
  }

  Widget _buildTimeline() {
    return Column(
      children: const [
        TimelineItem(
          year: '2021 – Present',
          title: 'Senior Flutter Developer',
          description:
              'Led development of 5+ production apps. Implemented BLoC pattern, custom animations, and CI/CD pipelines.',
        ),
        TimelineItem(
          year: '2019 – Present',
          title: 'Freelance UX/UI Designer',
          description:
              'Designed 20+ mobile & web interfaces in Figma. Delivered prototypes, design systems, and user testing reports.',
        ),
        TimelineItem(
          year: '2017 – 2021',
          title: 'BSc Computer Engineering',
          description:
              'First‑class honours. Capstone: AI‑powered habit tracker (Flutter + TensorFlow Lite).',
        ),
      ],
    );
  }

  Widget _buildContactForm() {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final messageController = TextEditingController();

    return Card(
      elevation: 8,
      color: const Color(0xFF1A1F1A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(FontAwesomeIcons.github,
                    size: 32, color: Color(0xFF42A5F5)),
                SizedBox(width: 32),
                FaIcon(FontAwesomeIcons.linkedin,
                    size: 32, color: Color(0xFF42A5F5)),
                SizedBox(width: 32),
                FaIcon(FontAwesomeIcons.twitter,
                    size: 32, color: Color(0xFF42A5F5)),
                SizedBox(width: 32),
                FaIcon(FontAwesomeIcons.instagram,
                    size: 32, color: Color(0xFF42A5F5)),
              ],
            ),
            const SizedBox(height: 32),
            TextField(
              controller: nameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Your Name',
                labelStyle: const TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFF4CAF50)),
                  borderRadius: BorderRadius.circular(16),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFF42A5F5), width: 2),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Email Address',
                labelStyle: const TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFF4CAF50)),
                  borderRadius: BorderRadius.circular(16),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFF42A5F5), width: 2),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: messageController,
              maxLines: 4,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Your Message',
                labelStyle: const TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFF4CAF50)),
                  borderRadius: BorderRadius.circular(16),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xFF42A5F5), width: 2),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                // For demo, just show a dialog. Replace with actual email sending.
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Message Sent!'),
                    content:
                        Text('Thanks ${nameController.text}, I’ll reply soon.'),
                    backgroundColor: const Color(0xFF1A1F1A),
                  ),
                );
                nameController.clear();
                emailController.clear();
                messageController.clear();
              },
              icon: const Icon(Icons.send),
              label: const Text('Send Message', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
      {required Key? key,
      required String id,
      required String title,
      required Widget child}) {
    return Container(
      key: key,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          child,
        ],
      ),
    );
  }

  void _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }
}
