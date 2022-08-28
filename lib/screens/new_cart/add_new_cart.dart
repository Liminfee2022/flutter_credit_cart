import 'package:credit_cart_form/contains.dart';
import 'package:credit_cart_form/screens/new_cart/components/card_type.dart';
import 'package:credit_cart_form/screens/new_cart/components/card_utilis.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'components/input_formatters.dart';

class AdNewCartScreen extends StatefulWidget {
  const AdNewCartScreen({Key? key}) : super(key: key);

  @override
  State<AdNewCartScreen> createState() => _AdNewCartScreenState();
}

class _AdNewCartScreenState extends State<AdNewCartScreen> {
  TextEditingController cardNumberController = TextEditingController();
  CardType cardType = CardType.Invalid;

  void getCardTypeFromNumber() {
    // with in first 6 digit we can identify the type so
    if (cardNumberController.text.length <= 6) {
      String cardNumber = CardUtils.getCleanedNumber(cardNumberController.text);
      CardType type = CardUtils.getCardTypeFrmNumber(cardNumber);
      if (type != cardType) {
        setState(() {
          cardType = type;
        });
      }
    }
  }

  @override
  void initState() {
    cardNumberController.addListener(() {
      getCardTypeFromNumber();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('New Card'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding, vertical: defaultPadding),
          child: Column(children: [
            Form(
                child: Column(
              children: [
                TextFormField(
                  controller: cardNumberController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(19),
                    CardNumberInputFormatter(),
                  ],
                  decoration: InputDecoration(
                      hintText: "Card number",
                      suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CardUtils.getCardIcon(cardType)),
                      prefixIcon: cardType == CardType.Invalid
                          ? null
                          : Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: SvgPicture.asset('assets/icons/card.svg'),
                            )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Full name',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: SvgPicture.asset('assets/icons/user.svg'),
                      ),
                    ),
                  ),
                ),
                Row(children: [
                  Expanded(
                      child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                      CardMonthInputFormatter(),
                    ],
                    decoration: InputDecoration(
                      hintText: 'CVV',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: SvgPicture.asset('assets/icons/Cvv.svg'),
                      ),
                    ),
                  )),
                  const SizedBox(
                    width: defaultPadding,
                  ),
                  Expanded(
                      child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(5),
                    ],
                    decoration: InputDecoration(
                      hintText: 'MM/YY',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: SvgPicture.asset('assets/icons/Cvv.svg'),
                      ),
                    ),
                  )),
                ]),
              ],
            )),
            const Spacer(flex: 2),
            OutlinedButton.icon(
              onPressed: () {},
              icon: SvgPicture.asset('assets/icons/scan.svg'),
              label: const Text('Scan'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: defaultPadding),
              child: ElevatedButton(
                child: const Text('Add Card'),
                onPressed: () {},
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
