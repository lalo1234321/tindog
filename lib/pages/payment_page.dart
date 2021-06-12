import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';


class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

final GlobalKey<FormState> formKey = GlobalKey<FormState>();
String cardNumber = "", expiryDate = "", cardHolderName = "", cvvCode = "";
bool isCvvFocused = false;
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    
    if (arguments != null) print(arguments['plan']);  
    return Scaffold(
      body: Column(

      children:<Widget>[
        SizedBox(height: 20),
        creditCard(),
        _form(),
        SizedBox(height: 0,),
        confirmButton( arguments )
      ] 
      
      )
    );
    
  }


  Widget confirmButton(Map arguments) {
    return ElevatedButton(
      onPressed: () {
        print('Realizando compra');
      },
      child: (arguments['plan'] == 1) ? Text('Confirmar compra mensual') :
        Text('Confirmar compra anual'),
      
    );
  }
  Widget creditCard() {
    return CreditCardWidget(
      cardType: CardType.visa,
      cardNumber: cardNumber,
      expiryDate: expiryDate,
      cardHolderName: cardHolderName,
      cvvCode: cvvCode,
      showBackView: isCvvFocused,
      width: MediaQuery.of(context).size.width,
      animationDuration: Duration(milliseconds: 1000),

    );
  }

  Widget _form() {
    return CreditCardForm(
        formKey: formKey,
        onCreditCardModelChange: onCreditCardModelChange,
        obscureCvv: true,
        obscureNumber: true,
        cardNumberDecoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Number',
          hintText: 'XXXX XXXX XXXX XXXX',
        ),
        expiryDateDecoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Expired Date',
          hintText: 'XX/XX',

        ),
        cvvCodeDecoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'CVV',
          hintText: 'XXX',
        ),
        cardHolderDecoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Card Holder Name',
        ),
      );

  }
  
  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
}
}