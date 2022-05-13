String contactUsUrl="https://www.venetianpines.com/contact";
String termsAndConditionUrl="https://www.venetianpines.com/terms";

bool isNumeric(String s) {
 if (s == null) {
   return false;
 }
 return double.tryParse(s) != null;
}