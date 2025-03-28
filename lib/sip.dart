import 'dart:math';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SipScreen extends StatefulWidget {
  const SipScreen({super.key});

  @override
  State<SipScreen> createState() => _SipScreenState();
}

class _SipScreenState extends State<SipScreen> {
  TextEditingController investmentController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController yearsController = TextEditingController();
  double final_value = 0;
  double investedAmount=0;
  double esreturn = 0;
  Map<String,double> dataMap = {};



  double SipRetrun(int principal, double rate, double years){
    var r = rate /12/100; //monthly interest rate
    var n = years * 12 ; // number of months

    Map<String,double> dataMap = {};

    final_value =  principal * (pow(1+r,n) - 1) / r * (1+r) ;
    investedAmount = principal * n; //invested amount
    esreturn = final_value - investedAmount;

    return final_value;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xF8F8F8FC),
      appBar: AppBar(
        title: Text(
          "Sip Calculator",
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                ask("Monthly Investment", investmentController,
                    Icons.currency_rupee),
                SizedBox(
                  height: 10,
                ),
                ask("Expected return rate(p.a)", rateController, Icons.percent),
                SizedBox(
                  height: 10,
                ),
                ask("Time Period(Yr)", yearsController, Icons.timer_rounded),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {

                      if(investmentController.text.isEmpty || rateController.text.isEmpty || yearsController.text.isEmpty)
                        {
                            Fluttertoast.showToast(msg: 'Please enter all details',backgroundColor:Color.fromRGBO(232, 181, 51, 1),textColor: Colors.black );
                        }
                        final_value = SipRetrun(int.parse(investmentController.text), double.parse(rateController.text), double.parse(yearsController.text));
                      dataMap={
                        "Invested Amount": investedAmount,
                        "Estimate Returns" : esreturn
                      };
                    });

                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(232, 181, 51, 1)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Calculate',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),

                if(final_value>0 ) Column(
                  children: [
                    ans("Invested Amount", investedAmount.toStringAsFixed(0)),
                    SizedBox(height: 20,),
                    ans("Estimated Returns", esreturn.toStringAsFixed(0)),
                    SizedBox(height: 20,),
                    ans("Final Value", final_value.toStringAsFixed(0)),
                    SizedBox(height: 20,),
                    PieChart(
                        dataMap: dataMap,
                        animationDuration: Duration(milliseconds: 500),
                        chartType: ChartType.ring,
                        colorList: [
                          Color.fromRGBO(232, 181, 51, 1),
                          Colors.blueAccent
                        ],
                      chartRadius: MediaQuery.of(context).size.width / 2,
                      legendOptions: LegendOptions(
                        legendShape: BoxShape.rectangle
                      ),
                      chartValuesOptions: ChartValuesOptions(
                        showChartValueBackground: false,
                        decimalPlaces: 0
                      ),
                      )
                    ],
                )



              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ask(String title, TextEditingController controller, IconData icon) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            )),
        Expanded(
          child: TextField(
            cursorColor: Colors.black,
            controller: controller,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: "10",
                hintStyle: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
                filled: true,
                fillColor: Color.fromRGBO(232, 181, 51, 0.09),
                border: InputBorder.none,
                prefixIcon: Icon(
                  icon,
                  color: Color.fromRGBO(232, 181, 51, 1),
                )),
          ),
        )
      ],
    );
  }

  Widget ans(String title,String res) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Text(
              title,
              style: TextStyle(
                  color: Color.fromRGBO(232, 181, 51, 1),
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            )),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(232, 181, 51, 0.09),
            ),
              child: Text(
           res,
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
          )),
        )
      ],
    );
  }
}
