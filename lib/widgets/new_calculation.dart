import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/calculated_values.dart';
import '../functions/calculate_time.dart';

class NewCalculation extends StatefulWidget {
  NewCalculation();

  @override
  _NewCalculationState createState() => _NewCalculationState();
}

/*
   Global userCalculation variable used in calculation_display file.
   I use List, because in future i plan to display previous calculations.
   In actual situation, better would be simple string with result.
 */

List<CalculatedValues> userCalculation = [];


class _NewCalculationState extends State<NewCalculation> {


  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate:DateTime(2030),
    ).then( (pickedDate) {
        if(pickedDate == null)
          return;
        setState( () {
          selectedDate = pickedDate;
        });
    });
  }


  @override
  Widget build(BuildContext context) {
    final curScaleFactor = MediaQuery.of(context).textScaleFactor;
    final List<String> _calculateOptions =  ['Years', 'Months', 'Days',  'Hours', 'Minutes', 'Seconds'];

    /* LayoutBuilder  provides parent widget`s constrains. It helps with sizing, because LayoutBuild`s final size will match its child`s size. */

    return LayoutBuilder(builder: (ctx, constraints) {

      final _dropDownButton = DropdownButton<String>(
        hint: Container(
          /* Wrapping Text widget into Container gives a possibility to use constraints,
             so the app can be responsive. Sometimes tho, device can be really small
             and that is the reason I have wrapped it into FittedBox either.
           */
          height:constraints.maxHeight * 0.1,
          child: FittedBox(
            child: Text(
              '${option != null ? option : 'Select option'}',
              style: TextStyle(
                fontSize: 14 * curScaleFactor,
              ),
            ),),
        ),
        items: _calculateOptions.map((String value) {
          return new DropdownMenuItem<String>(
              value: value,
              child: Container(
                  height:constraints.maxHeight * 0.075,
                  child:FittedBox(
                      child: new Text(
                          value,
                          style:TextStyle(
                            fontSize:12 * curScaleFactor,
                          ),),
                  ),
              ),
          );
        }).toList(),

        /* Set state saves value of clicked DropDownButton option to variable _option */
        onChanged: (String value) {
          setState(() {
            option = value;
          });

        },);





      final pickedDateText = 'Picked date : ${selectedDate != null ? DateFormat.yMd().format(selectedDate) : 'No date chosen!'}';

      final _datePicker = Container(
          height: constraints.maxHeight * 0.2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [ FittedBox(
                child: Text(
                  pickedDateText,
                  style: TextStyle(
                    fontSize:16 * curScaleFactor,
                  ),),
              ),
            FlatButton(
              textColor: Theme.of(context).primaryColor,
              child: Container(
                height: constraints.maxHeight * 0.075,
                child: FittedBox(
                  child: Text(
                    'Choose data',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 8 * curScaleFactor,
                    ),
                  ),
                ),
              ),
              onPressed: _showDatePicker,
            ),
          ],)
      );

      return Card(
        elevation: 10,
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _dropDownButton,
              _datePicker,
            ],
          ),
        ),
      );
    },);

  }}
