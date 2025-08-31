# Scanner QR/Barcode + Sqflite 💊📦

Simple, fast inventory and billing helper built with Flutter. Scan QR/Barcodes, search items, import/export CSV, and edit your local SQLite catalog. Works on mobile and desktop. 🚀

— — —

## 🇮🇶 شرح سريع (عربي عراقي)

هلا بيك! هذا التطبيق يفيدك بإدارة المنتجات والأدوية مالتك:

- مسح QR/Barcode بالكاميرا موبايل 📷 أو Scanner مكتبي ⌨️
- بحث سريع عن المواد 🔎 مع تصفية فورية
- قاعدة بيانات محلية Sqflite ويا قاعدة جاهزة pharmacy.db 💾
- إضافة/تعديل/حذف بيانات ➕✏️🗑️
- حساب الطلبات بالمسح ويطلعلك مجموع البيع 🧾➕
- تصدير واستيراد CSV 📤📥
- تحديث جماعي للأسعار (Cost/Sell) ⬆️💲
- يدعم عربي/إنكليزي 🌍 (l10n)

تشغيل سريع:

1) نزل المتطلبات (Flutter و SDK)
2) افتح المشروع وسوّي pub get
3) على ويندوز: شغّل `flutter run -d windows`  🖥️
4) على أندرويد: وصّل جهازك وشغّل `flutter run -d android` 🤖

ملاحظات مهمة:

- التصدير والاستيراد يحتاج صلاحيات تخزين. إذا طلب إذن وافق عليه ✅
- على ويندوز، المسح يكون غالبًا عبر جهاز Barcode Scanner (يدخل الكود كيبد). صفحة الكاميرا للموبايل.

— — —

## 🇬🇧 Quick Overview (English)

Lightweight Flutter app to manage a local product catalog and orders:

- Scan QR/Barcodes via mobile camera 📷 or desktop scanner ⌨️
- Instant search and filtering 🔎
- Local SQLite (sqflite) with bundled pharmacy.db 💾
- Add/Edit/Delete items ➕✏️🗑️
- Order screen with running total 🧾➕
- CSV import/export 📤📥
- Bulk price updates for Cost/Sell ⬆️💲
- i18n: English + Arabic 🌍

Run it:

1) Install Flutter + platforms
2) Get packages
3) Windows: `flutter run -d windows`  🖥️
4) Android: connect a device, `flutter run -d android` 🤖

— — —

## Features ✨

- Drawer actions: Orders (scanner), Export CSV, Import CSV, Update Prices, Delete All
- Live search in AppBar (tap the search icon) 🔎
- Pagination for large lists ⚡
- Responsive layout (desktop/mobile) 🧩

Key screens/routes:

- `/HOME` Home (list, search, drawer)
- `/QRViewExample` Orders scanning screen
- `/AddData`, `/EditData`, `/ShowInformation`, `/UpdatePrice`

Packages used:

- State mgmt: provider
- DB: sqflite, sqflite_common_ffi (desktop)
- Scan: qr_code_scanner, qr_bar_code_scanner_dialog
- Files/CSV: file_picker, csv
- UI: sizer, flutter_advanced_drawer, dropdown_search
- i18n: flutter_localizations

— — —

## Project Structure 🗂️

- `lib/main.dart`: App entry, routes, localization
- `lib/model/stateManagment/provider.dart`: App logic/state (search, scan, import/export, prices, pagination)
- `lib/Utils/database/DataBaseHelper.dart`: SQLite init (mobile/desktop) + queries
- `assets/pharmacy.db`: Pre-seeded database
- `lib/ui/pages/*`: UI pages (Home, QR view, Add/Edit, Update price…)

— — —

## Setup & Run ▶️

Requirements:

- Flutter >= 3.35.2, Dart >= 3.9.0
- For Android: Android SDK + device/emulator
- For Windows desktop: Windows toolchain enabled (`flutter config --enable-windows-desktop`)

Steps:

1) Get dependencies
2) Run on your target platform

Windows (recommended for desktop):

```
flutter pub get
flutter run -d windows
```

Android:

```
flutter pub get
flutter run -d android
```

— — —

## Permissions 🔐

Android Manifest hints (summary):

- Camera permission for scanning
- Storage/Media permissions for CSV import/export

The app already requests runtime permissions with `permission_handler`. Make sure your Manifest handles camera/storage on your target SDK level (Android 13+ has changes for media permissions).

— — —

## Usage Guide 🧭

Home:

- Tap the search icon to filter items live
- Open the drawer for actions

Orders (Scanner):

- Mobile: camera view scans codes and builds a list, showing the running total
- Desktop (Windows): use your USB barcode scanner; scanned items appear in the list and total updates

Import/Export CSV:

- Export: choose a folder; a `data.csv` file will be created
- Import: pick a CSV file with columns [Name, Barcode, Cost, Sell, ID]

Update Prices:

- Apply a delta to Cost or Sell for all rows (bulk update)

— — —

## Troubleshooting 🛠️

- Camera shows black screen on Android: ensure camera permission is granted and try restarting the app/device
- Desktop scanning not working: on Windows, scanning expects a hardware barcode scanner (keyboard input). The camera view is for mobile
- CSV import fails: check file format/columns and app storage permissions
- Database not found: confirm `assets/pharmacy.db` is bundled (it is declared in `pubspec.yaml`)

— — —

## i18n 🌐

Localizations live in `lib/generated` and ARB files under `lib/l10n`. Supported locales include Arabic and English. UI text like drawer labels and messages are translated.

— — —

## Dev Notes 👩‍💻👨‍💻

- State is managed in `MainProvider`
- Database access is abstracted in `DataBaseHelper` with mobile/desktop paths
- QR scanning uses `QRView` on mobile; Windows shows an order list suitable for keyboard scanners

— — —

## License 📄

If you plan to open-source, add a license here. Otherwise, treat as private/internal.

