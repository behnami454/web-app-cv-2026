import 'package:behnam_portfolio/features/background/data/models/certification_model.dart';
import 'package:behnam_portfolio/features/background/data/models/education_model.dart';
import 'package:behnam_portfolio/features/background/data/models/language_model.dart';

const certifications = [
  CertificationModel(
    title: 'Mikrotik Certification',
    issuer: 'Technical and Vocational Training Organization',
    year: '2022',
  ),
  CertificationModel(
    title: 'Photoshop Certification',
    issuer: 'Technical and Vocational Training Organization',
    year: '2021',
  ),
  CertificationModel(
    title: 'TTC Certification',
    issuer: 'Payam Noor University',
    year: '2020',
  ),
  CertificationModel(
    title: 'ILI English Certification',
    issuer: 'Iran Language Institute',
    year: '2020',
  ),
  CertificationModel(
    title: 'PET Certification',
    issuer: 'Cambridge ESOL',
    year: '2019',
  ),
];

const education = [
  EducationModel(
    degree: 'Bachelor of Computer Engineering',
    institution: 'Payam Noor University',
    period: '2018 - 2022',
  ),
];

const languages = [
  LanguageModel(
    name: 'English',
    level: 'Advanced',
  ),
  LanguageModel(
    name: 'Persian',
    level: 'Native',
  ),
];
