import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:societymanagement/Components/BillCard.dart';
import 'package:societymanagement/Components/ConnectivityCheck.dart';
import 'package:societymanagement/Components/CustomAppBar.dart';
import 'package:societymanagement/Screens/Login.dart';
import 'package:societymanagement/Utils/GetDetails.dart';
import 'package:societymanagement/Utils/GetSharedPref.dart';

class Summary extends StatefulWidget {
  static final String id = "Summary";
  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  String selecteddate;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Summary"),
          backgroundColor: Colors.blueAccent[700],
          actions: [
            // IconButton(
            //   icon: Icon(Icons.calendar_today),
            //   onPressed: () async {
            //     final now = await showDatePicker(
            //       context: context,
            //       firstDate: DateTime(1960),
            //       initialDate: DateTime.now(),
            //       lastDate: DateTime(2100));
            //     if(date != null) {
            //       var formatter = new DateFormat('yyyy-MM');
            //       setState(() {
            //         selecteddate = formatter.format(now);
            //       });
            //     }
            //   }
            // ),
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                sharedpref.clear();
                Navigator.pushReplacementNamed(context, Login.id);
              }
            ),
          ],
        ),
        // body: ConnectivityCheck(
        //   childView: ListView.separated(
        //     separatorBuilder: (context, index) => SizedBox(height: 5,),
        //     itemCount: 1,
        //     itemBuilder: (context, index) {
        //       return ListTile(
        //         title: Text("title"),
        //         subtitle: Text("subtitle")
        //       );
        //     },
        //   ),
        // ),
        body: ConnectivityCheck(
          childView: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: collectionReference.doc("Bill").collection(selecteddate ?? "2020-11").snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    if(snapshot.hasData) {
                      final bills = snapshot.data.docs;
                      List<BillCard> billsCards = [];
                      for (var bill in bills) {
                        final category = bill.id;
                        final amount = bill.data()['amount'];
                        final billsCard = BillCard(category: category, amount: amount,);
                        billsCards.add(billsCard);
                      }
                      return Expanded(child: ListView(children: billsCards,));
                    } else if(!snapshot.hasData) {
                      return Center(child: Text("No Bills Yet!!!"),);
                    }
                  }
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart' as charts;

// class _CostsData {
//   final String category;
//   final int cost;
//   const _CostsData(this.category, this.cost);
// }

// class PieChartExample extends StatefulWidget {
//   const PieChartExample({Key key}) : super(key: key);

//   @override
//   _PieChartExampleState createState() => _PieChartExampleState();
// }

// class _PieChartExampleState extends State<PieChartExample> {
//   // Chart configs.
//   bool _animate = true;
//   bool _defaultInteractions = true;
//   double _arcRatio = 0.8;
//   charts.ArcLabelPosition _arcLabelPosition = charts.ArcLabelPosition.auto;
//   charts.BehaviorPosition _titlePosition = charts.BehaviorPosition.bottom;
//   charts.BehaviorPosition _legendPosition = charts.BehaviorPosition.bottom;

//   // Data to render.
//   final List<_CostsData> _data = [
//     const _CostsData('Electricity', 40000),
//     const _CostsData('Water', 10500),
//     const _CostsData('Maintanence', 20000),
//     const _CostsData('Security', 30000),
//     const _CostsData('Events', 23000),
//     const _CostsData('Festivals', 45000),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final _colorPalettes =
//         charts.MaterialPalette.getOrderedPalettes(this._data.length);
//     return ListView(
//       padding: const EdgeInsets.all(8),
//       children: <Widget>[
//         SizedBox(
//           height: 300,
//           child: charts.PieChart(
//             // Pie chart can only render one series.
//             /*seriesList=*/ [
//               charts.Series<_CostsData, String>(
//                 id: 'Expense',
//                 colorFn: (_, idx) => _colorPalettes[idx].shadeDefault,
//                 domainFn: (_CostsData sales, _) => sales.category,
//                 measureFn: (_CostsData sales, _) => sales.cost,
//                 data: this._data,
//                 // Set a label accessor to control the text of the arc label.
//                 labelAccessorFn: (_CostsData row, _) =>
//                     '${row.category}: ${row.cost}',
//               ),
//             ],
//             animate: this._animate,
//             defaultRenderer: charts.ArcRendererConfig(
//               arcRatio: this._arcRatio,
//               arcRendererDecorators: [
//                 charts.ArcLabelDecorator(labelPosition: this._arcLabelPosition)
//               ],
//             ),
//             behaviors: [
//               // Add title.
//               charts.ChartTitle(
//                 'Dummy costs breakup',
//                 behaviorPosition: this._titlePosition,
//               ),
//               // Add legend. ("Datum" means the "X-axis" of each data point.)
//               charts.DatumLegend(
//                 position: this._legendPosition,
//                 desiredMaxRows: 2,
//               ),
//             ],
//           ),
//         ),
//         const Divider(),
//         ListView(children: [
//           _controlWidgets;
//         ])
//       ],
//     );
//   }

//   /// Widgets to control the chart appearance and behavior.
//   List<Widget> _controlWidgets() => <Widget>[
//         SwitchListTile(
//           title: const Text('animate'),
//           onChanged: (bool val) => setState(() => this._animate = val),
//           value: this._animate,
//         ),
//         SwitchListTile(
//           title: const Text('defaultInteractions'),
//           onChanged: (bool val) =>
//               setState(() => this._defaultInteractions = val),
//           value: this._defaultInteractions,
//         ),
//         const ListTile(title: Text('Arc width ratio w.r.t. radius:')),
//         Slider(
//           divisions: 10,
//           onChanged: (double val) => setState(() => this._arcRatio = val),
//           value: this._arcRatio,
//           label: '${this._arcRatio}',
//         ),
//         ListTile(
//           title: const Text('arcLabelPosition:'),
//           trailing: DropdownButton<charts.ArcLabelPosition>(
//             value: this._arcLabelPosition,
//             onChanged: (charts.ArcLabelPosition newVal) {
//               if (newVal != null) {
//                 setState(() => this._arcLabelPosition = newVal);
//               }
//             },
//             items: [
//               for (final val in charts.ArcLabelPosition.values)
//                 DropdownMenuItem(value: val, child: Text('$val'))
//             ],
//           ),
//         ),
//         ListTile(
//           title: const Text('titlePosition:'),
//           trailing: DropdownButton<charts.BehaviorPosition>(
//             value: this._titlePosition,
//             onChanged: (charts.BehaviorPosition newVal) {
//               if (newVal != null) {
//                 setState(() => this._titlePosition = newVal);
//               }
//             },
//             items: [
//               for (final val in charts.BehaviorPosition.values)
//                 DropdownMenuItem(value: val, child: Text('$val'))
//             ],
//           ),
//         ),
//         ListTile(
//           title: const Text('legendPosition:'),
//           trailing: DropdownButton<charts.BehaviorPosition>(
//             value: this._legendPosition,
//             onChanged: (charts.BehaviorPosition newVal) {
//               if (newVal != null) {
//                 setState(() => this._legendPosition = newVal);
//               }
//             },
//             items: [
//               for (final val in charts.BehaviorPosition.values)
//                 DropdownMenuItem(value: val, child: Text('$val'))
//             ],
//           ),
//         ),
//       ];
// }