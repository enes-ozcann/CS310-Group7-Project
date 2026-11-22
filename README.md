# smartPack

smartPack is a Flutter travel planning app for students and travellers. It suggests editable packing lists based on destination, weather, trip duration, and planned activities. Supporting features include a trip journal, place suggestions from a small tourist catalogue, and budget tracking.

## Group 7

| Name | Student ID |
|---|---|
| Enes Özcan | 35532 |
| Nehir Erdim | 35215 |
| Baler Çekmece | 35448 |
| Alara Bilik | 35672 |
| Şeyma Şahin | 28033 |

## Run the UI prototype

```sh
flutter pub get
flutter run
```

The app starts at the login screen. This prototype uses form validation and sample
data, so a valid email and a non-empty password open the app without a server.

The member folders under `lib` are `ab_alara`, `bc_baler`, `eo_enes`,
`ne_nehir`, and `ss_seyma`. The shared entry point is `lib/main.dart`.

Destination image files and the `SmartPackFont` font are not included yet.
Missing images display placeholders; the font falls back to the system font.

```sh
flutter analyze
flutter test
flutter build apk --debug
```
