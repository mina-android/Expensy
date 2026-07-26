git add .
git commit -m "feat: localize app and update onboarding (v1.0.7)"
git push
flutter build apk --release
flutter build apk --split-per-abi --release
flutter build appbundle --release
gh release create v1.0.7 -F release_notes.txt -t "v1.0.7" build/app/outputs/flutter-apk/*.apk build/app/outputs/bundle/release/*.aab
