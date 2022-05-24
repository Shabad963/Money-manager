import 'package:database/db/category/category_db..dart';
import 'package:database/db/transactions/transaction_db.dart';
import 'package:database/models/category/category_model.dart';
import 'package:database/models/transaction/transaction_model.dart';
import 'package:flutter/material.dart';

class ScreenaddTransaction extends StatefulWidget {
  static const routeName = 'add-transaction';
  const ScreenaddTransaction({Key? key}) : super(key: key);

  @override
  State<ScreenaddTransaction> createState() => _ScreenaddTransactionState();
}

class _ScreenaddTransactionState extends State<ScreenaddTransaction> {

  DateTime? _selectedDate;
  CategoryType? _selectedCategoryType;
  CategoryModel? _selectedCategoryModel;

  String? _categoryID;

  final _purposeTextEditingController = TextEditingController();

  final _amountTextEditingController = TextEditingController();

  @override
  void initState() {
    _selectedCategoryType = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //purpose
              TextFormField(
                controller: _purposeTextEditingController,
                decoration: const InputDecoration(
                  hintText: 'purpose'
                ),
              ),
              //amount
              TextFormField(
                controller: _amountTextEditingController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Amount'
                ),
              ),
              //calender
              TextButton.icon(
                  onPressed: () async{
                   final _selectDateTemp = await showDatePicker(
                     context: context,
                     initialDate: DateTime.now(),
                     firstDate: DateTime.now().subtract(const Duration(days: 30)),
                     lastDate: DateTime.now(),
                   );

                   if (_selectDateTemp == null) {
                     return;
                   }else{
                     print(_selectDateTemp.toString());
                     setState(() {
                     });
                     _selectedDate = _selectDateTemp;
                   }

                  },
                  icon: const Icon(Icons.calendar_today),
                  label: Text(_selectedDate == null ?'Select Date' : _selectedDate!.toString()),
                ),

              //category
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio(
                          value: CategoryType.income,
                          groupValue: _selectedCategoryType,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedCategoryType = CategoryType.income;
                              _categoryID = null;
                            });

                          },
                      ),
                      Text('income'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: CategoryType.expense,
                        groupValue: _selectedCategoryType,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCategoryType = CategoryType.expense;
                            _categoryID = null;
                          });
                        },
                      ),
                      Text('expense'),
                    ],
                  ),
                ],
              ),
              //categorytype
              DropdownButton<String>(
                hint: const Text('Select Category'),
                items: (_selectedCategoryType == CategoryType.income
                        ? CategoryDB().incomeCategoryListListener
                    :CategoryDB().expenseCategoryListListener)
                    .value
                    .map((e){
                return DropdownMenuItem(
                  value: e.id,
                  child: Text(e.name),
                  onTap: (){
                    _selectedCategoryModel == e;
                  },
                );
                }).toList(),
                onChanged: (selectedValue) {
                  print(selectedValue);
                  setState(() {
                    _categoryID = selectedValue;
                  });
              },
                onTap: () {},
              ),
              //Submit

              ElevatedButton(
                onPressed: (){
                  addTransaction();
                },
                child : Text('Submit'),
              )
            ],
          ),
       ),
      ),
    );
  }
  Future <void> addTransaction() async{

    final _purposeText = _purposeTextEditingController.text;
    final _amountText = _amountTextEditingController.text;
    if(_purposeText.isEmpty) {
      return;
    }
    if (_amountText.isEmpty) {
      return;
    }
    // if( _categoryID == null) {
    //   return;
    // }
    if(_selectedDate == null) {
      return;
    }
    if (_selectedCategoryModel == null) {
      return;
    }


    final _parsedAmount = double.tryParse(_amountText);
    if(_parsedAmount == null)
      {
        return;
      }
    //_selectDate
    //_selectedCategoryType
    //_categoryID

    final _model = TransactionModel(
      purpose: _purposeText,
        amount: _parsedAmount,
        date: _selectedDate!,
      type: _selectedCategoryType!,
      category: _selectedCategoryModel!,
    );

    await TransactionDB.instance.addTransaction(_model);
  Navigator.of(context).pop();
  TransactionDB.instance.refresh();
  }

}
