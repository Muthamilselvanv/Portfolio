# Muthamilselvan V — Flutter Developer Portfolio

A responsive Flutter Web portfolio designed for recruiter and interview use.

## Personalize before publishing

Update `lib/src/data/portfolio_data.dart` with verified employment dates,
company details, project URLs, and screenshot paths. Email, LinkedIn, GitHub,
and the current resume are already configured.

## Updating contact links manually

Open `lib/src/data/portfolio_data.dart` and edit only these centralized values:

```dart
static const email = 'your@email.com';
static const linkedIn = 'https://www.linkedin.com/in/your-profile/';
static const github = 'https://github.com/your-username';
```

## Replacing the resume manually

1. Copy the new PDF into `assets/resume/`.
2. Change `resumeAsset` in `lib/src/data/portfolio_data.dart` to its exact path.
3. Change the resume entry under `flutter/assets` in `pubspec.yaml` to the same path.
4. Run `flutter pub get`, stop the running app, and start it again.

Use a filename without spaces, for example `Muthamilselvan V_V_Resume.pdf`.

## Run and verify

```sh
flutter pub get
flutter run -d chrome
flutter analyze
flutter test
flutter build web --release
```

## Deploy

- Firebase Hosting: build with `flutter build web --release`, initialize Hosting,
  choose `build/web` as the public directory, then deploy.
- Netlify/Vercel: publish `build/web`; configure the build command as
  `flutter build web --release` where Flutter is available.
- GitHub Pages: build with the repository base path, for example
  `flutter build web --release --base-href /repository-name/`, then publish
  `build/web` with a Pages workflow.

Firebase Hosting is the simplest default for a Flutter portfolio because it has
first-class SPA routing, HTTPS, CDN delivery, and an easy custom-domain flow.
