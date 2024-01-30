import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';

var kColorScheme= ColorScheme.fromSeed(seedColor: const Color.fromARGB(
    116, 234, 18, 147));

var kDarkColorScheme= ColorScheme.fromSeed(seedColor: const Color.fromARGB(
    160, 72, 6, 72),
    brightness: Brightness.dark);
void main(){
  runApp(
     MaterialApp(
       darkTheme: ThemeData.dark().copyWith(
         useMaterial3: true,
         colorScheme: kDarkColorScheme,
          scaffoldBackgroundColor: kDarkColorScheme.primaryContainer,
         cardTheme: const CardTheme().copyWith(
           margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
           color: kDarkColorScheme.tertiaryContainer,
           shadowColor: kDarkColorScheme.shadow,
         ),
           elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
             backgroundColor: kDarkColorScheme.primaryContainer,
             foregroundColor: kDarkColorScheme.onPrimaryContainer,
           )),
       ),
      themeMode: ThemeMode.system,
      theme: ThemeData().copyWith(
        useMaterial3: true,
       colorScheme: kColorScheme,
        scaffoldBackgroundColor: kColorScheme.primaryContainer,
        appBarTheme: const AppBarTheme().copyWith(
          foregroundColor: kColorScheme.onPrimaryContainer ,
          backgroundColor: const Color.fromARGB(150, 239, 71, 71),
        ),

        cardTheme: const CardTheme().copyWith(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          color: kColorScheme.tertiaryContainer,
          shadowColor: kColorScheme.shadow,
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
          backgroundColor: kColorScheme.primaryContainer,
        )),

        textTheme: ThemeData().textTheme.copyWith(
          titleLarge:const  TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold,color: Colors.pinkAccent,
          ),
          titleSmall: const TextStyle(
            fontSize: 16 , fontWeight: FontWeight.w800,
          )
        ),
      ),
       debugShowCheckedModeBanner: false,
      home:const Expenses(),
    ),
  );
}
