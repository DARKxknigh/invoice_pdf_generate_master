import 'package:flutter/material.dart';
import 'package:invoice_pdf_generate_master/file_handle_api.dart';
import 'package:invoice_pdf_generate_master/pdf_invoice_api.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Invoice PDF Generate',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Theme
  PdfColor themeColor = PdfColors.black;
  String selectedFontName = 'Courier';

  pw.Font get selectedFont {
    switch (selectedFontName) {
      case 'Helvetica':
        return pw.Font.helvetica();
      case 'Times':
        return pw.Font.times();
      default:
        return pw.Font.courier();
    }
  }

  // Customer Info
  final _customerNameController = TextEditingController(text: 'John Doe');
  final _customerEmailController = TextEditingController(text: 'john@gmail.com');

  // Company Info
  final _companyNameController = TextEditingController(text: 'Flutter App');
  final _companyAddressController =
  TextEditingController(text: 'PURULIA,WESTBENGAL,723147');
  final _companyEmailController =
  TextEditingController(text: 'krishnendugorai17@gmail.com');

  // Body Text
  final _bodyTextController = TextEditingController(
    text:
    'Dear John,\nLorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborum numquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentium optio.',
  );

  // Invoice Items
  List<InvoiceItem> items = [
    InvoiceItem(description: 'Coffee', quantity: '7', unitPrice: '\$ 5', vat: '1 %', total: '\$ 35'),
    InvoiceItem(description: 'Blue Berries', quantity: '5', unitPrice: '\$ 10', vat: '2 %', total: '\$ 50'),
    InvoiceItem(description: 'Water', quantity: '1', unitPrice: '\$ 3', vat: '1.5 %', total: '\$ 3'),
    InvoiceItem(description: 'Apple', quantity: '6', unitPrice: '\$ 8', vat: '2 %', total: '\$ 48'),
    InvoiceItem(description: 'Lunch', quantity: '3', unitPrice: '\$ 90', vat: '12 %', total: '\$ 270'),
    InvoiceItem(description: 'Drinks', quantity: '2', unitPrice: '\$ 15', vat: '0.5 %', total: '\$ 30'),
    InvoiceItem(description: 'Lemon', quantity: '4', unitPrice: '\$ 7', vat: '0.5 %', total: '\$ 28'),
  ];

  // Totals
  final _netTotalController = TextEditingController(text: '\$ 464');
  final _vatController = TextEditingController(text: '\$ 90.48');
  final _totalDueController = TextEditingController(text: '\$ 554.48');

  @override
  void dispose() {
    _customerNameController.dispose();
    _customerEmailController.dispose();
    _companyNameController.dispose();
    _companyAddressController.dispose();
    _companyEmailController.dispose();
    _bodyTextController.dispose();
    _netTotalController.dispose();
    _vatController.dispose();
    _totalDueController.dispose();
    super.dispose();
  }

  void _addItem() {
    setState(() {
      items.add(InvoiceItem(
        description: 'New Item',
        quantity: '1',
        unitPrice: '\$ 0',
        vat: '0 %',
        total: '\$ 0',
      ));
    });
  }

  void _removeItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Invoice'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // ── Theme Section ──────────────────────────────
          _sectionTitle('Theme Settings'),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            decoration: _inputDecoration('Theme Color'),
            value: 'Black',
            items: const [
              DropdownMenuItem(value: 'Black', child: Text('Black')),
              DropdownMenuItem(value: 'Dark Grey', child: Text('Dark Grey')),
              DropdownMenuItem(value: 'Green', child: Text('Green')),
              DropdownMenuItem(value: 'Blue', child: Text('Blue')),
            ],
            onChanged: (value) {
              setState(() {
                switch (value) {
                  case 'Dark Grey':
                    themeColor = PdfColors.grey900;
                    break;
                  case 'Green':
                    themeColor = PdfColors.green;
                    break;
                  case 'Blue':
                    themeColor = PdfColors.blue;
                    break;
                  default:
                    themeColor = PdfColors.black;
                }
              });
            },
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            decoration: _inputDecoration('Font'),
            value: selectedFontName,
            items: const [
              DropdownMenuItem(value: 'Courier', child: Text('Courier')),
              DropdownMenuItem(value: 'Helvetica', child: Text('Helvetica')),
              DropdownMenuItem(value: 'Times', child: Text('Times')),
            ],
            onChanged: (value) => setState(() => selectedFontName = value!),
          ),
          const SizedBox(height: 20),

          // ── Customer Info ──────────────────────────────
          _sectionTitle('Customer Info'),
          const SizedBox(height: 8),
          TextField(
            controller: _customerNameController,
            decoration: _inputDecoration('Customer Name'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _customerEmailController,
            decoration: _inputDecoration('Customer Email'),
          ),
          const SizedBox(height: 20),

          // ── Company Info ───────────────────────────────
          _sectionTitle('Company Info'),
          const SizedBox(height: 8),
          TextField(
            controller: _companyNameController,
            decoration: _inputDecoration('Company Name'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _companyAddressController,
            decoration: _inputDecoration('Company Address'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _companyEmailController,
            decoration: _inputDecoration('Company Email'),
          ),
          const SizedBox(height: 20),

          // ── Body Text ──────────────────────────────────
          _sectionTitle('Invoice Body Text'),
          const SizedBox(height: 8),
          TextField(
            controller: _bodyTextController,
            decoration: _inputDecoration('Body Text'),
            maxLines: 4,
          ),
          const SizedBox(height: 20),

          // ── Invoice Items ──────────────────────────────
          _sectionTitle('Invoice Items'),
          const SizedBox(height: 8),
          ...items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Item ${index + 1}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _removeItem(index),
                        ),
                      ],
                    ),
                    _itemField(
                      'Description',
                      item.description,
                          (v) => item.description = v,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: _itemField(
                            'Quantity',
                            item.quantity,
                                (v) => item.quantity = v,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _itemField(
                            'Unit Price',
                            item.unitPrice,
                                (v) => item.unitPrice = v,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: _itemField(
                            'VAT',
                            item.vat,
                                (v) => item.vat = v,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _itemField(
                            'Total',
                            item.total,
                                (v) => item.total = v,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
          TextButton.icon(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
            label: const Text('Add Item'),
          ),
          const SizedBox(height: 20),

          // ── Totals ─────────────────────────────────────
          _sectionTitle('Totals'),
          const SizedBox(height: 8),
          TextField(
            controller: _netTotalController,
            decoration: _inputDecoration('Net Total'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _vatController,
            decoration: _inputDecoration('VAT Amount'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _totalDueController,
            decoration: _inputDecoration('Total Amount Due'),
          ),
          const SizedBox(height: 30),

          // ── Generate Button ────────────────────────────
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
            ),
            icon: const Icon(Icons.picture_as_pdf),
            label: const Text(
              'Generate Invoice PDF',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            onPressed: () async {
              final pdfFile = await PdfInvoiceApi.generate(
                color: themeColor,
                fontFamily: selectedFont,
                customerName: _customerNameController.text,
                customerEmail: _customerEmailController.text,
                companyName: _companyNameController.text,
                companyAddress: _companyAddressController.text,
                companyEmail: _companyEmailController.text,
                bodyText: _bodyTextController.text,
                items: items,
                netTotal: _netTotalController.text,
                vat: _vatController.text,
                totalDue: _totalDueController.text,
              );
              FileHandleApi.openFile(pdfFile);
            },
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: Colors.indigo,
      ),
    );
  }

  Widget _itemField(
      String label, String value, Function(String) onChanged) {
    return TextFormField(
      initialValue: value,
      decoration: _inputDecoration(label),
      onChanged: onChanged,
    );
  }
}