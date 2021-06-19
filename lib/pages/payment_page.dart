import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:provider/provider.dart';
import 'package:tindog/services/user_service.dart';


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
    final userService = Provider.of<UserService>(context);

    final arguments = ModalRoute.of(context).settings.arguments as Map;
    
    if (arguments != null) print(arguments['plan']);  
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(

        children:<Widget>[
          SizedBox(height: 20),
          creditCard(),
          _form(),
          SizedBox(height: 0,),
          confirmButton( userService, arguments )
        ] 
        
        ),
      )
    );
    
  }


  Widget confirmButton(UserService userService, Map arguments) {
    
    return ElevatedButton(
      onPressed: () async{
        if( cardNumber == "" || expiryDate == ""|| cardHolderName == "" || cvvCode == "" ) {
          _showAlertDialog(context, "Error", "No llenó los campos correctamente");
        } else {
          await userService.upgradeAccount(arguments['plan']);
          _showAlertDialog(context, "Gracias por su compra", "La compra se ha realizado con éxito");
        }
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
          labelText: 'Número',
          hintText: 'XXXX XXXX XXXX XXXX',
        ),
        expiryDateDecoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Fecha de expiración',
          hintText: 'XX/XX',

        ),
        cvvCodeDecoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'CVV',
          hintText: 'XXX',
        ),
        cardHolderDecoration: const InputDecoration(
          
          border: OutlineInputBorder(),
          labelText: 'Portador de la tarjeta',
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

  void _showAlertDialog( BuildContext context, String title, String subtitle ) {
    showDialog(
      context: context,
      builder: (buildcontext) {
        return AlertDialog(
          title: Text(title),
          content: Text(subtitle),
          actions: <Widget>[
            TextButton(
            child: Text("Aceptar"),
            onPressed: () {
              Navigator.pushNamed(context, 'match');
            }),
          ],
        );
      }
    );
  }
}