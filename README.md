# Invoice PDF Generator 🧾

A Flutter application that allows users to create and customize professional invoice PDFs directly on their device. All processing happens locally — no internet required.

---

## Features

- 🎨 **Theme Customization** — Choose invoice color (Black, Dark Grey, Green, Blue)
- 🔤 **Font Selection** — Switch between Courier, Helvetica, and Times fonts
- 👤 **Customer Info** — Edit customer name and email
- 🏢 **Company Info** — Edit company name, address, and email
- 📝 **Body Text** — Customize the invoice message
- 🛒 **Invoice Items** — Add, edit, and remove line items (description, quantity, unit price, VAT, total)
- 💰 **Totals** — Edit net total, VAT amount, and total amount due
- 📄 **PDF Generation** — Instantly generate and open a professional PDF invoice

---

## Screenshots

> _Add your screenshots here_

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter 3.x (Dart 3) |
| PDF Engine | pdf ^3.10.4 |
| File Handling | path_provider ^2.1.1 |
| File Opening | open_file ^3.3.2 |

---

## Project Structure

```
lib/
├── main.dart                 — App entry point & editable invoice UI
├── pdf_invoice_api.dart      — PDF generation logic
└── file_handle_api.dart      — File save & open utilities

assets/
└── icon.png                  — Invoice logo/icon
```

---

## Getting Started

### Prerequisites

- Flutter SDK `>=3.1.2`
- Dart SDK `>=3.0.0`
- Android Studio or VS Code
- A physical device or emulator (Android / iOS)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/invoice_pdf_generate_master.git
   cd invoice_pdf_generate_master
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Add the invoice icon**

   Place your icon PNG at:
   ```
   assets/icon.png
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

---

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  open_file: ^3.3.2
  path_provider: ^2.1.1
  pdf: ^3.10.4
```

---

## Platform Permissions

### Android
Add to `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
```

### iOS
Add to `ios/Runner/Info.plist`:
```xml
<key>NSPhotoLibraryAddUsageDescription</key>
<string>Invoice PDF Generator needs permission to save files.</string>
```

---

## How It Works

1. Open the app
2. Fill in customer and company details
3. Add or edit invoice line items
4. Set net total, VAT, and total due
5. Choose a theme color and font
6. Tap **Generate Invoice PDF**
7. The PDF opens automatically on your device

---

## Architecture

```
UI (main.dart)
    │
    ▼
PdfInvoiceApi.generate()     — Builds the PDF document
    │
    ▼
FileHandleApi.saveDocument() — Saves PDF to device storage
    │
    ▼
FileHandleApi.openFile()     — Opens PDF with device viewer
```

---

## Privacy

Invoice PDF Generator processes all files **locally on your device**.

- No files are uploaded to any server
- No analytics or tracking
- No internet permission required
- Files are saved to the app's documents directory

---

