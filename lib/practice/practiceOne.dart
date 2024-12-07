import 'dart:io';
import 'dart:math';
void Practice() {
  print('Enter your name:');
  String? name = stdin.readLineSync();
  print('Hello, $name!');
  stdout.write("Enter full name: ");
  String? full_name = stdin.readLineSync();
  stdout.write("Enter your age : ");
  int age = int.parse(stdin.readLineSync()!);
  print("Hello :  $full_name your calculated age is : $age");
}

int AddInt(int a, int b) {
  return a + b;
}

Future<String> fetchData() async {
  await Future.delayed(Duration(seconds: 2));
  return 'Data fetched';
}

int findLargest(int num1,int num2){
  if(num1 > num2) {
    print("$num1 is greater");
    return num1;
  } else if(num1 < num2){
    print("$num2 is greater");
    return num2;
  } else {
    print("$num1 and $num2 are equal");

  }
  return 0;
}

int checkEven(int a) {
  if (a % 2 == 0) {
    print('number is even : $a');
  } else {
    print('number is odd : $a');
  }
  return a;
}

int collectionSum(List<int> items) {
  int sum = 0;
  int n = items.length;
  for(var i = 0; i < n;i++){
    sum += items[i];
  }
  return sum;
}

String collectionEvenSum(List<int> items) {
  int sum = 0;
  for (var i = 0; i < items.length; i++) {
    if (items[i] % 2 == 0) {
      sum += items[i];
    }
  }
  return "Sum of even numbers: $sum";
}

String reverseElement(List<String> items) {
  String names = '';
  for(var i = items.length - 1; i >= 0; i--) {
    names += items[i];
    if(i>0) {
      names += ' ';
    }
  }
  return names;
}

String reverseElementOfNames(String name) {
  String names = '';
  for(var i = name.length - 1; i>=0;i--) {
    names += name[i];
  }
  return names;
}


String factorialNumber(int num) {
  int fact =1;
  for(var i=2;i<=num; i++) {
    fact *= i;
  }

  return "Factorial $fact";
}

String useSet(Set<int> setElement) {
  setElement.addAll([21,33,45]);
  setElement.remove(21);
  setElement.removeAll([21,33]);
  setElement.clear();

  for(var i = 1; i<5; i++) {
    setElement.clear();
    print(setElement);
    setElement.addAll([21,23,25,27,29]);
    setElement.add(i);
  }
  print(setElement.contains(21));
  print(setElement.containsAll([33,45]));
  print(setElement.isEmpty);
  print(setElement.isNotEmpty);
  print(setElement.lookup(21));
  print(setElement.first);
  print(setElement.last);
  print(setElement.toString().runtimeType);
  print(setElement.toList().runtimeType);
  return"Updated Set is $setElement";
}

String useList(List<int> items) {
  //items.add(4);
  //items.addAll([1,2,3,4,5,6,6,7]);
  print(items.first);
  print(items.last);
  print(items.reversed);
  print(items.isEmpty);
  print(items.isNotEmpty);
  print(items.iterator);
  print(items.runtimeType);
  print(items.length);
  items.addAll([12,23,24,56]);
  print(items.length);
  print(items.toString());
  items.insert(0, 1);
  items.insertAll(3, [99,88,77]);
  print(items);
  items.sort();
  print(items);
  print(items.remove(1));
  print(items);
  print(items.removeAt(4));
  print(items);
  print(items.reversed.toString());
  print(items.reversed.toList(growable: true));
  print(items.reversed.toSet());
  items.shuffle();
  items.sort();
  print(items);
  List<int>doubled = items.map((num) => num * 5).toList();
  print(doubled);
  List newDoubled = items.map((num) => num  / 5).toList();
  print(newDoubled);
  newDoubled.removeRange(2, 6);
  print(newDoubled);
  return "";
}

bool areAllPositiveNumber(List<int> numbers) {
  bool allPositive = true;

  for (int number in numbers) {
    if (number <= 0) {
      allPositive = false;
      break;
    }
  }

  return allPositive;
}

List printPostiveNumber(List<int> number) {
  List num = [];
  for(int i = 0; i< number.length;i++) {
    if(number[i] > 0) {
      num.add(number[i]);

    }
  }
  return num;
}
// void main() {
//   // stdout.write("Enter the value of a: ");
//   // int a = int.parse(stdin.readLineSync()!);
//   // stdout.write("Enter the value of b: ");
//   // int b = int.parse(stdin.readLineSync()!);
//   // print(a % 2  == 0 ? 'Even' : 'Odd');
//   //print(checkEven(a));
//
//   // List<int> items = [21,22,34,45,52];
//   // print(collectionSum(items));
//   // print(collectionEvenSum(items));
//   // reverseElement(['a','b','c','d','e','f']);
//   // String result = reverseElement(['a','b','c','d','e','f']);
//   // print(result);
//   // String name = reverseElementOfNames("Mayur Kumar Bobade");
//   // print(name);
//
//   //print(findLargest(a, b));
//   // print(AddInt(a, b));
//   //print(fetchData());
//   // String fact = factorialNumber(5);
//   // print(fact);
//
//   // String setElement = useSet({21,33,42,15,62});
//   // print(setElement);
//   String listElement = useList([1,2,3,4]);
//   print(listElement);
//   // var p = Person("Mayur", 23);
//   // print(p.name);
//   // print(p.age);
//   // p.sayHello();
//   var details = BankAccountData("Mayur Kumar", 25, 244554443332, 9898989898,'jlw09090','123456');
//   details.checkUserDetails();
// }

class Person {
  String name;
  int age;

  // Default constructor
  Person(this.name, this.age);

  // Named constructor
  Person.fromBirthYear(this.name, int birthYear) : age = DateTime.now().year - birthYear;

  // Instance method
  void sayHello() {
    print('Hello, my name is $name.');
  }
}


class BankAccountData{
  String userName;
  String Password;
  String name;
  int accNo;
  int age;
  int mobileNo;
  BankAccountData(this.name,this.age,this.accNo,this.mobileNo,this.userName,this.Password);
  //MARK: Named Constructor
  BankAccountData.BankDetails(this.name,this.accNo,this.age,this.mobileNo,this.userName,this.Password);
  void checkUserDetails() {
    if(Login(userName, Password, '') == 'Success') {
      greet();
      name = this.name;
      age = this.age;
      accNo = this.accNo;
      mobileNo = this.mobileNo;
      print("----------------Hello Thanks for comming here----------------");
      print("user name : -- $name");
      print("Account number : -- $accNo");
      print("Mobile number : -- $mobileNo");
      print("Age  : -- $age");
      List<int> number = [0,-1,2,3,-3,-5];
      // bool isPositive = areAllPositiveNumber(number);
      // print(isPositive);
      List list = printPostiveNumber(number);
      print(list);
    } else {
      print("Unauthorized  Request");
    }

  }
  String greet({String message = 'Hello! Welcome to Open Community Platform'}) {
    print('$message, $name!');
    return name + message;
  }
  String Login(String userId, String Password, String message) {
    if(userId == 'jlw09090' && Password == '123456') {
      message = 'Success';
    } else {
      message = 'Failed';
    }
    return message;
  }
}


//MARK 100 codes
//5Check if a Number is Positive or Negative
String checkPositiveNegative(int num) {
  String result = '';
  if(num > 0) {
    result = 'Positive $num';
  } else if(num == 0) {
    result = 'Zero $num';
  } else {
    result = 'Negative $num';
  }
  return result;
}

//6MARK Even odd

void evenOdd(int num) {
  if (num % 2 == 0) {
    print("Number is Even : $num");
  } else {
    print("Number is Odd : $num");
  }
}

//7MARK Sum of n natural number
int sumOfNnaturalNum(int num) {
  int sum = 0;
  for(int i = 0; i<= num;i++) {
    sum += i;
  }
  return sum;
}

//8MARK Sum of natural number in range
int sumOfNumberInRange(int start, int end) {
  int sum = 0;
  for(int i = start; i<=end; i++) {
    sum += i;
  }
  return sum;
}

//9MARK find the greatest number
int findGreatestNumber(int num1,int num2) {
  int max = 0;
  if(num1>num2) {
    max = num1;
    print("num1 is greater then num2 $max");
  } else if(num1 == num2) {
    max = num1;
    print("num1 and num2 are equal");
  } else {
    max = num1;
    print("num2 is greater then num1 $max");
  }
  return max;
}

//MARK find the Greatest of the Three numbers:
int findGreatestOfThreeNumber(int num1,int num2, int num3) {
  int max = 0;
  if(num1>num2 && num1 > num3) {
    max = num1;
    print("num1 is greater then num2 and num3 $max");
  } else if(num2 > num1 && num2 > num3) {
    max = num2;
    print("num2 is greater then num1 and num3 $max");
  } else if(num3 > num1 && num3 > num2) {
    max = num3;
    print("num3 is greater then num1 and num2 $max");
  } else {
    max = num1;
    print("num1 num2 num3 are equal $max");
  }
  return max;
}
//MARK Leap year or not:
void leapYear(int year) {
  if (year % 400 == 0) {
    print("$year is a leap year");
  } else if (year % 4 == 0 && year % 100 != 0) {
    print("$year is a leap year");
  } else {
    print("$year is not a leap year");
  }
}
//10MARK Prime number or not:
bool primeNumber(int num) {
  int count  = 0;
  for(int i = 1; i<=num; i++) {
    if(num%i==0 && num%1==0) {
      count += 1;
    }
  }
  if(num == 1 || num == 0) {
    print("$num is not prime");
    return false;
  } else if(count > 2) {
    print("$num is not prime");
    return false;
  } else {
    print("$num is prime");
    return true;
  }
}

//11MARK: Prime number within a given range:
int primeNumberInRange(int a, int b) {
  for(int i = a; i<=b; i++) {
    if(primeNumber(i)) {
      print("prime number $i");
    }
  }
  return 0;
}

bool checkPrimeOrNot(int num) {
  int count = 0;
  for(int i = 1; i <=num;i++) {
    if(num % i == 0 && num%1==0) {
      count += 1;
    }
  }
  if(num == 0 && num == 1 ){
    return false;
  } else if(count > 2) {
    return false;
  } else {
    return true;
  }
}

int primeRange(int num1, int num2) {
  for(int i=num1;i<=num2;i++) {
    if(checkPrimeOrNot(i)) {
      print("prime number $i");
    }
  }
  return 0;
}

//12 MARK Sum of digit in a number
int sumOfDigit(int num) {
  int sum = 0;
  while(num > 0){
    sum += num % 10;
    num = (num / 10).toInt();
  }
  return sum;
}

//13 MARK Reverse digit in a number
int reverseOfDigit(int num) {
  int rev = 0;
  int rem = 0;
  while(num>0){
    rem = num % 10;
    rev = rev * 10 + rem;
    num = (num / 10).toInt();
  }
  return rev;
}

//14 MARK Palindrome digit in a number
bool checkPalindrome(int num) {
  int rem = 0;
  int rev = 0;
  int temp = num;
  while(temp != 0) {
    rem = temp % 10;
    rev = (rev * 10) + rem;
    temp = (temp / 10).toInt();
  }
  if (rev == num) {
    print("this number is palindrome");
    return true;
  } else {
    print("this number is not palindrome");
    return false;
  }
}

bool chechArmstrongNumber(int num) {
  int sum = 0;
  int temp = num;
  int count = 0;

  // count the number in digit
  while(temp != 0) {
    temp = (temp / 10).toInt();
    count += 1;
  }

  //calculate the sum of each digit raised to the power of count
  temp = num;
  while(temp != 0) {
    int rem = temp % 10;
    int pow = 1;
    for(int i = 0; i < count; i++) {
      pow *= rem;
    }

    sum += pow;
    temp = (temp / 10).toInt();
  }

  if (sum == num) {
    print("number is armstrong $sum");
    return true;
  } else {
    print("number is not armstrong $sum");
    return false;
  }
}
class PracticeProgram {

  //MARK 1:- smallest in array
  int smallestInArray(List<int> arr) {
    int smallest = arr[0];
    for (int i = 0; i < arr.length; i++) {
      if (arr[i] < smallest) {
        smallest = arr[i];
      }
    }
    return smallest;
  }

  //MARK 2:- largest in array
  int largestInArray(List<int>arr) {
    int largest = arr[0];
    for (int i = 0; i < arr.length; i++) {
      if (arr[i] > largest) {
        largest = arr[i];
      }
    }
    return largest;
  }

  //MARK 3:- smallest And Largest in array
  Map<String, int> smallestAndLargest(List<int> arr) {
    int smallest = arr[0];
    int largest = arr[0];
    for (int i = 1; i < arr.length; i++) {
      if (arr[i] > largest) {
        largest = arr[i];
      } else if (arr[i] < smallest) {
        smallest = arr[i];
      }
    }
    return {'Smallest': smallest, 'Largest': largest};
  }

  //MARK 4:- smallest And Largest in array
  Map<String, int> secondSmallestInArray(List<int> arr) {
    int smallest = arr[0];
    int secondSmallest = arr[0];
    for (int i = 1; i < arr.length; i++) {
      if (arr[i] < smallest) {
        secondSmallest = smallest;
        smallest = arr[i];
      } else if (arr[i] < secondSmallest && arr[i] != smallest) {
        secondSmallest = arr[i];
      }
    }
    return {'Smallest': smallest, 'Second Smallest': secondSmallest};
  }

//MARK 5:- sum of an array
  int sumOfAnArray(List<int> arr) {
    int sum = 0;
    for (int i = 0; i < arr.length; i++) {
      sum += arr[i];
    }
    return sum;
  }

//MARK 6:- Reverse of an array
  List reverseOfAnArray(List<int> arr) {
    List reversed = [];
    for (int i = arr.length - 1; i >= 0; i--) {
      reversed.add(arr[i]);
    }
    return reversed;
  }

//MARK 7:- Sort Half an array in ascending order and Half in desending order
  List halfSort(List<int> arr) {
    int mid = arr.length ~/ 2;
    for (int i = 0; i < mid; i++) {
      for (int j = i + 1; j < mid; j++) {
        if (arr[i] > arr[j]) {
          int temp = arr[i];
          arr[i] = arr[j];
          arr[j] = temp;
        }
      }
    }

    for (int i = mid; i < arr.length; i++) {
      for (int j = i + 1; j < arr.length; j++) {
        if (arr[i] < arr[j]) {
          int temp = arr[i];
          arr[i] = arr[j];
          arr[j] = temp;
        }
      }
    }
    return arr;
  }

  //Mark: 8 Sort the array in asending order default
  List sortArray(List<int> arr) {
    for (int i = 0; i < arr.length; i++) {
      for (int j = i + 1; j < arr.length; j++) {
        if (arr[i] > arr[j]) {
          int temp = arr[i];
          arr[i] = arr[j];
          arr[j] = temp;
        }
      }
    }
    return arr;
  }

  List sortArrayDesc(List<int> arr) {
    for (int i = 0; i < arr.length; i++) {
      for (int j = i + 1; j < arr.length; j++) {
        if (arr[i] < arr[j]) {
          int temp = arr[i];
          arr[i] = arr[j];
          arr[j] = temp;
        }
      }
    }
    return arr;
  }

  //MARK: smallest element
  int findSmallElementArrays(List<int> arr) {
    int smallest = arr[0];
    for (int i = 0; i < arr.length; i++) {
      if (arr[i] < smallest) {
        smallest = arr[i];
      }
    }
    return smallest;
  }

  //MARK: Largest element
  int findLargestElementArrays(List<int> arr) {
    int largest = arr[0];
    for (int i = 0; i < arr.length; i++) {
      if (arr[i] > largest) {
        largest = arr[i];
      }
    }
    return largest;
  }

  //MARK Half array in Aescending or half array in desending order
  List sortAescDescOrder(List<int> arr) {
    int mid = arr.length ~/ 2;
    for (int i = 0; i < mid; i++) {
      for (int j = i + 1; j < mid; j++) {
        if (arr[i] < arr[j]) {
          int temp = arr[i];
          arr[i] = arr[j];
          arr[j] = temp;
        }
      }
    }
    for (int i = mid; i < arr.length; i++) {
      for (int j = i + 1; j < arr.length; j++) {
        if (arr[i] > arr[j]) {
          int temp = arr[i];
          arr[i] = arr[j];
          arr[j] = temp;
        }
      }
    }
    return arr;
  }

  //MARK reverse array
  List reverseList(List<int> arr) {
    List<int> reverse = [];
    for (int i = arr.length - 1; i >= 0; i--) {
      reverse.add(arr[i]);
    }
    return reverse;
  }

  //MARK Frequency of array
  Map<int, int> countFrequency(List<int> arr) {
    Map<int, int> frequency = {};

    for (int i = 0; i < arr.length; i++) {
      bool found = false;
      for (int j = 0; j < i; j++) {
        if (arr[i] == arr[j]) {
          found = true;
          break;
        }
      }
      if (!found) {
        int count = 0;
        for (int j = 0; j < arr.length; j++) {
          if (arr[i] == arr[j]) {
            count ++;
          }
        }
        frequency[arr[i]] = count;
      }
    }
    return frequency;
  }

  //MARK: frequency
  // Map<String, int> countStringFrequency(List<String> arr) {
  //   Map<String, int> frequency = {};
  //   List<String> list = [];
  //   for (int i = 0; i < arr.length; i++) {
  //     bool found = false;
  //     for (int j = 0; j < i; j++) {
  //       if (arr[i] == arr[j]) {
  //         found = true;
  //         break;
  //       }
  //     }
  //
  //     if (!found) {
  //       int count = 0;
  //       for (int j = 0; j < arr.length; j++) {
  //         if (arr[i] == arr[j]) {
  //           count++;
  //         }
  //       }
  //       frequency[arr[i]] = count;
  //     }
  //
  //   }
  //   return frequency;
  // }
  Map<String, int> countStringFrequency(List<String> arr) {
    Map<String, int> frequency = {};

    // Step 1: Count the frequency of each element.
    for (int i = 0; i < arr.length; i++) {
      bool found = false;
      for (int j = 0; j < i; j++) {
        if (arr[i] == arr[j]) {
          found = true;
          break;
        }
      }

      if (!found) {
        int count = 0;
        for (int j = 0; j < arr.length; j++) {
          if (arr[i] == arr[j]) {
            count++;
          }
        }
        frequency[arr[i]] = count;
      }
    }

    // Step 2: Convert map entries to a list and sort them by frequency.
    List<MapEntry<String, int>> sortedEntries = frequency.entries.toList();
    for(int i = 0; i< sortedEntries.length; i++) {
      for(int j = 0;j<i; j++) {
        if(sortedEntries[i].value < sortedEntries[j].value) {
          MapEntry<String, int> temp = sortedEntries[i];
          sortedEntries[i] = sortedEntries[j];
          sortedEntries[j] = temp;

        }
      }
    }
    Map<String, int> sortedFrequency = {};
    for(var entry in sortedEntries) {
      sortedFrequency[entry.key] = entry.value;
    }
    return sortedFrequency;
  }
}
// void main() {
//   var p = PracticeProgram();
//   // var res = p.smallestInArray([10,9,11,12]);
//   // var res = p.largestInArray([10,9,11,12]);
//   //var res = p.smallestAndLargest([10,9,11,12]);
//   // var res = p.secondSmallestInArray([10,9,9,11,12,1]);
//   // var res = p.sumOfAnArray([10,9,1]);
//   // var res = p.reverseOfAnArray([10,9,1,4,5]);
//   // var res = p.halfSort([10,9,1,4,5,2,3]);
//   // stdout.write("Enter Number: ");
//   // int num1 = int.parse(stdin.readLineSync()!);
//   //stdout.write("Enter Number: ");
//   // int num2 = int.parse(stdin.readLineSync()!);
//   // stdout.write("Enter Number: ");
//   // int num3 = int.parse(stdin.readLineSync()!);
//   // var result = checkPositiveNegative(num1);
//   // var result = sumOfNnaturalNum(num1);
//   // var result = sumOfNumberInRange(num1,num2);
//   //var result = findGreatestNumber(num1,num2);
//   //findGreatestOfThreeNumber(num1,num2,num3);
//   // var result = findGreatestOfThreeNumber(num1,num2,num3);
//   // print(result);
//   // evenOdd(result);
//   // leapYear(num1);
//   //primeRange(num1,num2);
//   // var res = sumOfDigit(num1);
//   // var res = reverseOfDigit(num1);
//   // var res = checkPalindrome(num1);
//
//   // var res = p.findSmallElementArrays([10,9,1,4,5,2,3]);
//   // var res = p.findLargestElementArrays([10,9,1,4,5,2,3]);
//   // var res = p.sortAescDescOrder([10,9,1,4,5,2,3]);
//   // var res = p.reverseList([10,9,1,4,5,2,3]);
//   //var res = p.countFrequency([10,10,9,9,1,4,5,2,3]);
//   var res = p.countStringFrequency(['a', 'a', 'a', 'b', 'c', 'd', 'd']);
//   // var desc = p.sortArrayDesc([10,9,1,4,5,2,3]);
//   print(res);
//   // print(desc);
// }
//Parking Lot

//Main Function

class ParkingLot {
  final int totalSpots;
  int usedSpots = 0;
  int moterCycleSpots;
  int vanSpots = 0;
  ParkingLot(this.totalSpots, this.moterCycleSpots);

  //TODO: Tell us how many total spots are in the parking lot
  bool addVehicle(int spotsAvailable) {
    if (usedSpots + spotsAvailable <= totalSpots) {
      usedSpots += spotsAvailable;
      return true;
    }
    return false; //Not Enough Space
  }
  //Tell us how many spots are remaining
  int remainingSpots() {
    return totalSpots - usedSpots;
  }
  // Tell us when the parking lot is full
  bool isFullParkingLot() {
    return usedSpots == totalSpots;
  }

  // Tell us when the parking lot is empty
  bool isEmptyParkingLot() {
    return usedSpots == 0;
  }
  // Tell us when certain spots are full e.g. when all motorcycle spots are
  bool motorCycleSpotFull() {
    return moterCycleSpots == totalSpots;
  }

  bool vanPark() {
    if(addVehicle(3)) {
      vanSpots ++;
      return true;
    }
    return false;
  }

  // Tell us how many spots vans are taking up
  int vansInLot() {
    return vanSpots * 3;
  }
}
  //Main Function
// void main() {
//   print("Enter total available spots:");
//   int totalSpots = int.parse(stdin.readLineSync()!);
//
//   print("Enter total motorcycle spots:");
//   int motorcycleSpots = int.parse(stdin.readLineSync()!);
//
//   ParkingLot lot = ParkingLot(totalSpots, motorcycleSpots);
//
//   while (true) {
//     print("\n--- Parking Lot Menu ---");
//     print("1. Park a Vehicle");
//     print("2. Check Remaining Spots");
//     print("3. Check if Parking Lot is Full");
//     print("4. Check if Parking Lot is Empty");
//     print("5. Check if Motorcycle Spots are Full");
//     print("6. Park a Van");
//     print("0. Exit");
//     print("Enter your choice:");
//
//     int choice;
//     try {
//       choice = int.parse(stdin.readLineSync()!);
//     } catch (e) {
//       print("Invalid input. Please enter a number.");
//       continue;
//     }
//
//     switch (choice) {
//       case 1:
//         print("Enter the number of spots needed:");
//         int spotsNeeded = int.parse(stdin.readLineSync()!);
//         if (lot.addVehicle(spotsNeeded)) {
//           print("Vehicle parked successfully.");
//         } else {
//           print("Not enough space to park.");
//         }
//         break;
//
//       case 2:
//         print("Remaining spots: ${lot.remainingSpots()}");
//         break;
//
//       case 3:
//         print(lot.isFullParkingLot()
//             ? "The parking lot is full."
//             : "The parking lot is not full.");
//         break;
//
//       case 4:
//         print(lot.isEmptyParkingLot()
//             ? "The parking lot is empty."
//             : "The parking lot is not empty.");
//         break;
//
//       case 5:
//         print(lot.motorCycleSpotFull()
//             ? "Motorcycle spots are full."
//             : "Motorcycle spots are available.");
//         break;
//
//       case 6:
//         if (lot.vanPark()) {
//           print("Van parked successfully.");
//         } else {
//           print("Not enough space to park the van.");
//         }
//         break;
//
//       case 0:
//         print("Exiting...");
//         return;
//
//       default:
//         print("Invalid choice. Please try again.");
//     }
//   }
//
// }

Map<String,int> findSecondSmallAndLarge(List<int> arr) {
  int secondSmall = arr[0];
  int secondLarge = arr[0];
  int large = arr[0];
  int small = arr[0];
  for(int i =0; i< arr.length; i++) {
    if(arr[i]< small) {
      secondSmall = small;
      small  = arr[i];
    } else if(arr[i]< secondSmall && small != secondSmall) {
      secondSmall = arr[i];
    }
      if(arr[i] > large) {
        secondLarge = large;
        large = arr[i];
      } else if(secondLarge > arr[i] && secondLarge != large) {
        secondLarge = arr[i];

    }

    // if(arr[i] > large) {
    //   secondLarge = large;
    //   large = arr[i];
    //
    // } else if(arr[i] > secondLarge  && large != secondLarge) {
    //   if (large < secondLarge) {
    //     print(large);
    //     print(secondLarge);
    //     secondLarge = arr[i];
    //   }
    //
    // }
  }
  return {"Second Small" : secondSmall, "SecondLarge" : secondLarge};
}

// List reversedArray(List<int> arr) {
//   List<int> revArr = [];
//   for(int i = arr.length - 1; i >= 0; i--) {
//     revArr.add(arr[i]);
//   }
//   return revArr;
// }

// List reversedHalf(List<int>arr) {
//   int mid = arr.length ~/ 2;
//   for(int i = 0; i< mid; i++) {
//     for(int j = i+1; j<mid; j++) {
//       if(arr[i] < arr[j]) {
//         int temp = arr[i];
//         arr[i] = arr[j];
//         arr[j] = temp;
//       }
//     }
//   }
//   for(int i = mid; i< arr.length; i++) {
//     for(int j = i + 1; j< arr.length; j++) {
//       if(arr[i] > arr[j]) {
//         int temp = arr[i];
//         arr[i] = arr[j];
//         arr[j] = temp;
//       }
//     }
//   }
//   return arr;
// }

// Map<int,int> countFrequency(List<int> arr) {
//   Map<int, int> frequency = {};
//   for(int i =0; i<arr.length; i++) {
//     bool found = false;
//     for(int j=0; j<i; j++) {
//       if(arr[i] == arr[j]) {
//         found = true;
//       }
//     }
//     if(!found) {
//       int count = 0;
//       for(int j = 0; j<arr.length; j++) {
//         if(arr[i] == arr[j]) {
//           count++ ;
//         }
//       }
//       frequency[arr[i]] = count;
//     }
//   }
//   return frequency;
// }

Map<int,int> countFrequency(List<int> arr) {
  Map<int, int> frequency = {};
  for(int i=0; i < arr.length; i++) {
    bool found = false;
    for(int j = 0; j<i; j++) {
      if(arr[i] == arr[j]) {
        found = true;
       // break;
      }
    }
    if(!found) {
      int count = 0;
      for (int j = i + 1; j < arr.length; j++) {
        if (arr[i] == arr[j]) {
          count++;
        }
      }
      frequency[arr[i]] = count;
    }
  }
  return frequency;
}
List<int> sortByFrequency(List<int> arr) {
  Map<int,int> frequency = countFrequency(arr);
  for(int i=0; i<arr.length; i++) {
    for(int j = i+1; j<arr.length; j++) {
      if(frequency[arr[i]]! < frequency[arr[j]]!){
        int temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
      }
    }
  }
  return arr;
}

String findLongestPalindrome(List<String> arr) {
  String longest = '';
  for (String str in arr) {
    if (str == str.split('').reversed.join() && str.length > longest.length) {
      longest = str;
    }
  }
  return longest;
}

int countDistinct(List<int> arr) {
  int count = 0;
  for (int i = 0; i < arr.length; i++) {
    bool isDistinct = true;
    for (int j = 0; j < i; j++) {
      if (arr[i] == arr[j]) {
        isDistinct = false;
        break;
      }
    }
    if (isDistinct) {
      count++;
    }
  }
  return count;
}

Set<int> findRepeating(List<int> arr) {
  Set<int> repeating = {};
  for (int i = 0; i < arr.length; i++) {
    for (int j = i + 1; j < arr.length; j++) {
      if (arr[i] == arr[j]) {
        repeating.add(arr[i]);
      }
    }
  }
  return repeating;
}


//add not repeating value

Set<int> findNonRepeatValue(List<int> arr) {
  Set<int> nonRepeat = {};
  for(int i=0; i<arr.length;i++) {
    bool isUnique = true;
    for(int j=0; j<arr.length; j++) {
      if(i != j && arr[i] == arr[j]) {
        isUnique = false;

        break;
      }
    }
    if(isUnique) {
      nonRepeat.add(arr[i]);
    }
  }
  return nonRepeat;
}

bool isBalanced(String s) {
  List<String> stack = [];
  for (var char in s.split('')) {
    if (char == '(') {
      stack.add(char);
    } else if (char == ')') {
      if (stack.isEmpty || stack.last != '(') {
        return false;
      }
      stack.removeLast();
    }
  }
  return stack.isEmpty;
}

//palindrome

String reversedString(String s) {
  String reversed = '';
  for(int i = s.length-1;i>=0;i--) {
    reversed += s[i];
  }
  return reversed;
}

bool isPalindrome(String s) {
  String reversed = reversedString(s);
  return s == reversed;
}

//return first non repeating char

String returnFirstNonRepeatChar(String s) {
  Map<String,int> freq = {};
  for(var char in s.split('')) {
    freq[char] = (freq[char] ?? 0) + 1;
  }
  for(var char in s.split('')) {
    if(freq[char] == 1) {
      return char;
    }
  }
  return '';
}

//return frequency count of number
Map<String,int>frequencyCount(String s) {
  Map<String,int> freq = {};
  for(var char in s.split('')) {
    freq[char] = (freq[char] ?? 0) + 1;
  }
  return freq;
}

String removeDuplicate(String s) {
  Set<String> seen  = {};
  String result = '';
  for(var char in s.split('')) {
    if(!seen.contains(char)) {
      seen.add(char);
      result += char;
    }
  }
  return result;
}

//longestSubstringWithout repeat
int longestSubSting(String s) {
  Set<String> current = {};
  int start = 0, maxLength = 0;
  for(int i=0; i<s.length; i++) {
    while(current.contains(s[i])) {
      current.remove(s[start]);
      start++;
    }
    current.add(s[i]);
    maxLength = maxLength > (i-start + 1) ? maxLength: (i-start + 1);
  }
  return maxLength;
}

bool areAnagrams(String s1, String s2) {
  List<String> sort(String s) {
    List<String> chars = s.split('');
    for (int i = 0; i < chars.length - 1; i++) {
      for (int j = 0; j < chars.length - i - 1; j++) {
        if (chars[j].compareTo(chars[j + 1]) > 0) {
          var temp = chars[j];
          chars[j] = chars[j + 1];
          chars[j + 1] = temp;
        }
      }
    }
    return chars;
  }

  return sort(s1).join() == sort(s2).join();
}


//String are anagrams
bool checkAnagrams(String s1, String s2) {
  List<String> sort(String s) {
    List<String> chars = s.split('');
    for(int i = 0; i<chars.length-1;i++){
      for(int j=0;j<chars.length-i-1;j++) {
        if(chars[j].compareTo(chars[j+1]) > 0) {
          var temp = chars[j];
          chars[j] = chars[i];
          chars[i] = temp;
        }
      }
    }
    return chars;
  }
  return sort(s1).join() == sort(s2).join();
}

bool check(String s1, String s2) {
  List<String> sort(String s) {
    List<String> chars = s.split('');
    for(int i = 0; i<chars.length - 1; i++) {
      for(int j = 0; j<chars.length -i- 1; j++) {
        if(chars[j].compareTo(chars[j+1])>0) {
          var temp = chars[j];
          chars[j] = chars[i];
          chars[i] = temp;
        }
      }
    }
    return chars;
  }
  return sort(s1).join() == sort(s2).join();
}

//replace all occurance
String replaceAllChar(String s, String target,String replace) {
  String res = '';
  for(var char in s.split('')) {
    res += (char == target) ? replace:char;
  }
  return res;
}

bool containsOnlyDigits(String s) {
  for (var char in s.split('')) {
    if (char.codeUnitAt(0) < 48 || char.codeUnitAt(0) > 57) {
      return false;
    }
  }
  return true;
}
//substring of string

List<String> findSubstringOfString(String s) {
  List<String> result = [];
  for(int i = 0;i<s.length;i++) {
    String temp = '';
    for(int j = i; j<s.length;j++) {
      temp += s[j];
      result.add(temp);
    }
  }
  return result;
}

List<String> sub(String s) {
  List<String> result = [] ;
  for(int i = 0; i<s.length; i++) {
    String temp = '';
    for(int j = i;j<s.length;j++) {
      temp +=s[j];
      result.add(temp);
    }
  }
  return result;
}
void main() {
  List<int> arr = [1, 2, 2, 3, 4, 4, 5];
  var res = isBalanced(")({)}(");
  var palindrome = isPalindrome('mayau');
  var nonRepeat = frequencyCount('mayurmay');
  var removeDupl = removeDuplicate('mayur bobade');
  var subString = longestSubSting("this is longest channel");
  var am = areAnagrams("maxString", "gnirtsxam");
  print(am);
 // print("Number of distinct elements: ${findNonRepeatValue(arr)}");
}
