// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Hi, I’m Behnam Iranmanesh`
  String get heroTitle {
    return Intl.message(
      'Hi, I’m Behnam Iranmanesh',
      name: 'heroTitle',
      desc: '',
      args: [],
    );
  }

  /// `Flutter Developer`
  String get heroRole {
    return Intl.message(
      'Flutter Developer',
      name: 'heroRole',
      desc: '',
      args: [],
    );
  }

  /// `I build scalable, high-performance Flutter applications for web and mobile platforms.`
  String get heroDescription {
    return Intl.message(
      'I build scalable, high-performance Flutter applications for web and mobile platforms.',
      name: 'heroDescription',
      desc: '',
      args: [],
    );
  }

  /// `About Me`
  String get aboutTitle {
    return Intl.message('About Me', name: 'aboutTitle', desc: '', args: []);
  }

  /// `Projects`
  String get projectsTitle {
    return Intl.message('Projects', name: 'projectsTitle', desc: '', args: []);
  }

  /// `Experience`
  String get experienceTitle {
    return Intl.message(
      'Experience',
      name: 'experienceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Contact`
  String get contactTitle {
    return Intl.message('Contact', name: 'contactTitle', desc: '', args: []);
  }

  /// `Skills`
  String get skillsTitle {
    return Intl.message('Skills', name: 'skillsTitle', desc: '', args: []);
  }

  /// `Background`
  String get backgroundTitle {
    return Intl.message(
      'Background',
      name: 'backgroundTitle',
      desc: '',
      args: [],
    );
  }

  /// `Production applications, enterprise systems, and scalable Flutter solutions I’ve worked on.`
  String get projectsSubtitle {
    return Intl.message(
      'Production applications, enterprise systems, and scalable Flutter solutions I’ve worked on.',
      name: 'projectsSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Feel free to reach out for collaborations, freelance projects, or full-time opportunities.`
  String get contactSubtitle {
    return Intl.message(
      'Feel free to reach out for collaborations, freelance projects, or full-time opportunities.',
      name: 'contactSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Education, certifications and communication skills.`
  String get backgroundSubtitle {
    return Intl.message(
      'Education, certifications and communication skills.',
      name: 'backgroundSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Download CV`
  String get downloadCv {
    return Intl.message('Download CV', name: 'downloadCv', desc: '', args: []);
  }

  /// `Contact Me`
  String get contactMe {
    return Intl.message('Contact Me', name: 'contactMe', desc: '', args: []);
  }

  /// `Send Email`
  String get sendEmail {
    return Intl.message('Send Email', name: 'sendEmail', desc: '', args: []);
  }

  /// `LinkedIn`
  String get linkedin {
    return Intl.message('LinkedIn', name: 'linkedin', desc: '', args: []);
  }

  /// `View Code`
  String get viewCode {
    return Intl.message('View Code', name: 'viewCode', desc: '', args: []);
  }

  /// `Live Demo`
  String get liveDemo {
    return Intl.message('Live Demo', name: 'liveDemo', desc: '', args: []);
  }

  /// `404 - Page not found`
  String get pageNotFound {
    return Intl.message(
      '404 - Page not found',
      name: 'pageNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Behnam Iranmanesh`
  String get appName {
    return Intl.message(
      'Behnam Iranmanesh',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Toggle theme`
  String get toggleTheme {
    return Intl.message(
      'Toggle theme',
      name: 'toggleTheme',
      desc: '',
      args: [],
    );
  }

  /// `Hi, I’m`
  String get heroGreeting {
    return Intl.message('Hi, I’m', name: 'heroGreeting', desc: '', args: []);
  }

  /// `I build `
  String get heroLine1 {
    return Intl.message('I build ', name: 'heroLine1', desc: '', args: []);
  }

  /// `scalable Flutter apps`
  String get heroHighlight {
    return Intl.message(
      'scalable Flutter apps',
      name: 'heroHighlight',
      desc: '',
      args: [],
    );
  }

  /// `with clean architecture, performance, and modern UI/UX`
  String get heroLine2 {
    return Intl.message(
      'with clean architecture, performance, and modern UI/UX',
      name: 'heroLine2',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `No projects found`
  String get noProjectsFound {
    return Intl.message(
      'No projects found',
      name: 'noProjectsFound',
      desc: '',
      args: [],
    );
  }

  /// `Try a different filter`
  String get tryDifferentFilter {
    return Intl.message(
      'Try a different filter',
      name: 'tryDifferentFilter',
      desc: '',
      args: [],
    );
  }

  /// `Read more`
  String get readMore {
    return Intl.message('Read more', name: 'readMore', desc: '', args: []);
  }

  /// `Show less`
  String get showLess {
    return Intl.message('Show less', name: 'showLess', desc: '', args: []);
  }

  /// `Problem`
  String get problem {
    return Intl.message('Problem', name: 'problem', desc: '', args: []);
  }

  /// `Solution`
  String get solution {
    return Intl.message('Solution', name: 'solution', desc: '', args: []);
  }

  /// `Architecture`
  String get architecture {
    return Intl.message(
      'Architecture',
      name: 'architecture',
      desc: '',
      args: [],
    );
  }

  /// `Challenges`
  String get challenges {
    return Intl.message('Challenges', name: 'challenges', desc: '', args: []);
  }

  /// `Impact`
  String get impact {
    return Intl.message('Impact', name: 'impact', desc: '', args: []);
  }

  /// `Behnam Iranmanesh | Flutter Developer`
  String get appTitle {
    return Intl.message(
      'Behnam Iranmanesh | Flutter Developer',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get errorUnexpected {
    return Intl.message(
      'Something went wrong',
      name: 'errorUnexpected',
      desc: '',
      args: [],
    );
  }

  /// `Education`
  String get educationTitle {
    return Intl.message(
      'Education',
      name: 'educationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Certifications`
  String get certificationsTitle {
    return Intl.message(
      'Certifications',
      name: 'certificationsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Languages`
  String get languagesTitle {
    return Intl.message(
      'Languages',
      name: 'languagesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Featured`
  String get featured {
    return Intl.message('Featured', name: 'featured', desc: '', args: []);
  }

  /// `Select Language`
  String get selectLanguage {
    return Intl.message(
      'Select Language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `No experience found`
  String get noExperienceFound {
    return Intl.message(
      'No experience found',
      name: 'noExperienceFound',
      desc: '',
      args: [],
    );
  }

  /// `CV downloaded successfully`
  String get cvDownloadStarted {
    return Intl.message(
      'CV downloaded successfully',
      name: 'cvDownloadStarted',
      desc: '',
      args: [],
    );
  }

  /// `I’m a Flutter developer focused on building scalable, modern, and high-performance applications for web and mobile platforms.`
  String get aboutDescription1 {
    return Intl.message(
      'I’m a Flutter developer focused on building scalable, modern, and high-performance applications for web and mobile platforms.',
      name: 'aboutDescription1',
      desc: '',
      args: [],
    );
  }

  /// `I enjoy creating responsive UI, architecting clean and maintainable systems, and delivering smooth user experiences with strong attention to performance, scalability, and modern design principles.`
  String get aboutDescription2 {
    return Intl.message(
      'I enjoy creating responsive UI, architecting clean and maintainable systems, and delivering smooth user experiences with strong attention to performance, scalability, and modern design principles.',
      name: 'aboutDescription2',
      desc: '',
      args: [],
    );
  }

  /// `Flutter & Dart`
  String get flutterDartTitle {
    return Intl.message(
      'Flutter & Dart',
      name: 'flutterDartTitle',
      desc: '',
      args: [],
    );
  }

  /// `Cross-platform development`
  String get flutterDartSubtitle {
    return Intl.message(
      'Cross-platform development',
      name: 'flutterDartSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Responsive UI`
  String get responsiveUiTitle {
    return Intl.message(
      'Responsive UI',
      name: 'responsiveUiTitle',
      desc: '',
      args: [],
    );
  }

  /// `Modern web experiences`
  String get responsiveUiSubtitle {
    return Intl.message(
      'Modern web experiences',
      name: 'responsiveUiSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Clean Architecture`
  String get cleanArchitectureTitle {
    return Intl.message(
      'Clean Architecture',
      name: 'cleanArchitectureTitle',
      desc: '',
      args: [],
    );
  }

  /// `Scalable code structure`
  String get cleanArchitectureSubtitle {
    return Intl.message(
      'Scalable code structure',
      name: 'cleanArchitectureSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Performance`
  String get performanceTitle {
    return Intl.message(
      'Performance',
      name: 'performanceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Optimized applications`
  String get performanceSubtitle {
    return Intl.message(
      'Optimized applications',
      name: 'performanceSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `15+ Apps Worked On`
  String get heroStatApps {
    return Intl.message(
      '15+ Apps Worked On',
      name: 'heroStatApps',
      desc: '',
      args: [],
    );
  }

  /// `5+ Built From Scratch`
  String get heroStatScratch {
    return Intl.message(
      '5+ Built From Scratch',
      name: 'heroStatScratch',
      desc: '',
      args: [],
    );
  }

  /// `3 Years Experience`
  String get heroStatExperience {
    return Intl.message(
      '3 Years Experience',
      name: 'heroStatExperience',
      desc: '',
      args: [],
    );
  }

  /// `Enterprise & Healthcare Systems`
  String get heroStatEnterprise {
    return Intl.message(
      'Enterprise & Healthcare Systems',
      name: 'heroStatEnterprise',
      desc: '',
      args: [],
    );
  }

  /// `Flutter Web & Mobile`
  String get heroStatPlatforms {
    return Intl.message(
      'Flutter Web & Mobile',
      name: 'heroStatPlatforms',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'nl'),
      Locale.fromSubtags(languageCode: 'pl'),
      Locale.fromSubtags(languageCode: 'ro'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'tr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
