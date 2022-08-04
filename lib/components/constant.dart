// TextFormField(
// style: Theme.of(context).textTheme.bodyText2,
// validator: (value){
// if(value.isEmpty)
// return 'Search must be not empty';
// return null;
// },
// onSaved:(value){
// Searchcontroller = value as TextEditingController;
// },
// onChanged: (value){
// NewsCubit.get(context).getSearch(value);
// },
// controller: Searchcontroller,
// keyboardType: TextInputType.text,
// decoration: InputDecoration(
// focusedBorder: OutlineInputBorder(
// borderSide: BorderSide(color: Colors.deepOrange,),
//  borderRadius: BorderRadius.circular(25.0),
// ),
// labelText: 'Search',
// hintText: 'Search',
// labelStyle: TextStyle(color: Colors.deepOrange),
// prefixIcon: Icon(Icons.search, color: Colors.deepOrange,),
// border: OutlineInputBorder(),
// )
//
// ),

String token = '';