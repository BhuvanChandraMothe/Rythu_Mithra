import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentPage extends StatefulWidget {
  final String totalPrice;

  const PaymentPage({required this.totalPrice, Key? key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String _selectedPaymentMethod = 'Card';
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _expiryDateController = TextEditingController();
  TextEditingController _cvvController = TextEditingController();
  TextEditingController _cardHolderNameController = TextEditingController();
  TextEditingController _upiIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.grey[800],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Payment",
                style: GoogleFonts.notoSerif(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              // Display Total Price
              Text(
                "Total Price: \₹${widget.totalPrice}",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              // Payment Method Options
              Text("Select Payment Method", style: TextStyle(fontSize: 18)),
              ListTile(
                title: const Text('UPI'),
                leading: Radio<String>(
                  value: 'UPI',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value!;
                    });
                  },
                ),
              ),
              if (_selectedPaymentMethod == 'UPI')
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _upiIdController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'UPI ID',
                    ),
                  ),
                ),
              ListTile(
                title: const Text('Net Banking'),
                leading: Radio<String>(
                  value: 'Net Banking',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value!;
                    });
                  },
                ),
              ),
              if (_selectedPaymentMethod == 'Net Banking')
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset('lib/images/sbi.png', width: 50, height: 50),
                      Image.asset('lib/images/icici.png',
                          width: 50, height: 50),
                      Image.asset('lib/images/hdfc.png', width: 50, height: 50),
                      Image.asset('lib/images/axis.png', width: 50, height: 50),
                    ],
                  ),
                ),
              ListTile(
                title: const Text('Card'),
                leading: Radio<String>(
                  value: 'Card',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value!;
                    });
                  },
                ),
              ),
              if (_selectedPaymentMethod == 'Card') _buildCardForm(),
              ListTile(
                title: const Text('Cash On Delivery'),
                leading: Radio<String>(
                  value: 'Cash On Delivery',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value!;
                    });
                  },
                ),
              ),
              if (_selectedPaymentMethod == 'Cash On Delivery')
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Please choose prepaid option if possible..",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              SizedBox(height: 20),

              // Make Payment Button
              ElevatedButton(
                onPressed: () {
                  // Implement payment processing logic here
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Text(
                      'Make Payment',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCardAnimation(),
        SizedBox(height: 20),
        TextField(
          controller: _cardNumberController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Card Number',
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) => setState(() {}),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _expiryDateController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Expiry Date',
                ),
                keyboardType: TextInputType.datetime,
                onChanged: (value) => setState(() {}),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: TextField(
                controller: _cvvController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'CVV',
                ),
                keyboardType: TextInputType.number,
                obscureText: true,
                onChanged: (value) => setState(() {}),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        TextField(
          controller: _cardHolderNameController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Card Holder Name',
          ),
          onChanged: (value) => setState(() {}),
        ),
      ],
    );
  }

  Widget _buildCardAnimation() {
    return Container(
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF846AFF),
            Color(0xFF755EE8),
            Colors.purpleAccent,
            Colors.amber,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Card Number',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            _cardNumberController.text.isNotEmpty
                ? _cardNumberController.text
                : 'XXXX XXXX XXXX XXXX',
            style:
                TextStyle(color: Colors.white, fontSize: 24, letterSpacing: 2),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Expiry Date',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    _expiryDateController.text.isNotEmpty
                        ? _expiryDateController.text
                        : 'MM/YY',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CVV',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    _cvvController.text.isNotEmpty
                        ? _cvvController.text
                        : 'XXX',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          Text(
            _cardHolderNameController.text.isNotEmpty
                ? _cardHolderNameController.text
                : 'CARD HOLDER',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
