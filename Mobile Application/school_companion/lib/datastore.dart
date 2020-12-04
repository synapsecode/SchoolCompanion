import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_udid/flutter_udid.dart';

Map<String, dynamic> userInfo;

Map<String, dynamic> getUserInfo() {
  return userInfo;
}

assignUserInfo(Map<String, dynamic> obj) {
  Map<String, dynamic> x;
  x = {
    "student_name": obj["student_name"],
    "grade": obj["grade"],
    "section": obj["section"],
    "roll_no": obj["roll_no"],
    "username": obj["username"],
    "gender": obj["gender"],
    "email": obj["email"],
    "phone": obj["phone"],
    "country": obj["country"],
    "state": obj["state"],
    "city": obj["city"],
    "address": obj["address"],
    "dob": obj["dob"],
    "security_question": obj["security_question"],
    "security_answer": obj["security_answer"],
    "bio": obj["bio"],
    "profile_pic": obj["profile_pic_URL"],
    "posts": obj["posts"]
  };
  userInfo = x;
}

destroyUserInfo() {
  userInfo = {};
}

String convertMonth(String month) {
  String convertedMonth = "";
  switch (month) {
    case "Jan":
      convertedMonth = "01";
      break;
    case "Feb":
      convertedMonth = "02";
      break;
    case "Mar":
      convertedMonth = "03";
      break;
    case "Apr":
      convertedMonth = "04";
      break;
    case "May":
      convertedMonth = "05";
      break;
    case "Jun":
      convertedMonth = "06";
      break;
    case "Jul":
      convertedMonth = "07";
      break;
    case "Aug":
      convertedMonth = "08";
      break;
    case "Sep":
      convertedMonth = "09";
      break;
    case "Oct":
      convertedMonth = "10";
      break;
    case "Nov":
      convertedMonth = "11";
      break;
    case "Dec":
      convertedMonth = "12";
      break;
  }
  return convertedMonth;
}

String convertSubject(String subject) {
  String convertedSubject = "";
  switch (subject) {
    case "Physics":
      convertedSubject = "PHY";
      break;
    case "Chemistry":
      convertedSubject = "CHEM";
      break;
    case "Biology":
      convertedSubject = "BIO";
      break;
    case "Mathematics":
      convertedSubject = "MAT";
      break;
    case "History & Civics":
      convertedSubject = "HIS";
      break;
    case "Geography":
      convertedSubject = "GEO";
      break;
    case "English Grammar":
      convertedSubject = "ENG1";
      break;
    case "English Literature":
      convertedSubject = "ENG2";
      break;
    case "Computer Science":
      convertedSubject = "COMP";
      break;
    case "Physical Education":
      convertedSubject = "PE";
      break;
    case "Second Language":
      convertedSubject = "LNG";
      break;
  }
  return convertedSubject;
}

String getSubject(String subject) {
  switch (subject) {
    case "PHY":
      subject = "Physics";
      break;
    case "CHEM":
      subject = "Chemistry";
      break;
    case "BIO":
      subject = "Biology";
      break;
    case "MAT":
      subject = "Mathematics";
      break;
    case "HIS":
      subject = "History & Civics";
      break;
    case "GEO":
      subject = "Geography";
      break;
    case "ENG1":
      subject = "English Grammar";
      break;
    case "ENG2":
      subject = "English Literature";
      break;
    case "COMP":
      subject = "Computer Applications";
      break;
    case "PE":
      subject = "Physical Education";
      break;
    case "LNG":
      subject = "Second Language";
      break;
  }
  return subject;
}

String getGrade(String grade) {
  return grade != "ISC"
      ? grade == "A"
          ? "Everyone"
          : grade.substring(1)
      : "ISC";
}

String convertTimeStamp(String timeobj) {
  List<String> timestamps = (timeobj.split(",")[1]).split(" ");
  return "${timestamps[1]}/${convertMonth(timestamps[2])}/${timestamps[3]}";
}

String server = 'https://8d85f35c9c4c.ngrok.io/api';

Future<Map<String, dynamic>> requestLogin(username, password) async {
  print("Initiated Login Request");
  //String url = '$server/studentlogin/$username/$password';
  String url = '$server/studentlogin';
  var data = json.encode({'username': username, 'password': password});

  http.Response response = await http.post(url,
      headers: {"Content-Type": "application/json"}, body: data);
  Map<String, dynamic> responseBody = jsonDecode(response.body);
  print("\n\nLOGIN RESULT: $responseBody");
  print("Completed Login Request");
  String udid = await FlutterUdid.udid;
  print(udid);
  return responseBody;
}

void initServer(String serverURL) {
  server = serverURL;
}

Future getVideosByTopic(String topic) async {
  print("Initiated VideoByTopic Request for topic: $topic");
  String url = '$server/videosbytopic/$topic';
  http.Response response = await http.get(url);
  return jsonDecode(response.body);
}

Future getNotes(String subject, String grade) async {
  print("Initiated Notes Request for subject: $subject");
  String url = '$server/notes/G$grade/$subject';
  http.Response response = await http.get(url);
  return jsonDecode(response.body);
}

Future getSamplePapers(String subject, String grade) async {
  grade = "G$grade";
  print("Initiated SamplePaper Request for subject: $subject");
  String url = '$server/samplepapers/$grade/$subject';
  http.Response response = await http.get(url);
  return jsonDecode(response.body);
}

Future getResults(String studentName, String semester, String year) async {
  print("Initiated GetResults Request for studentName: $studentName");
  String url = '$server/results/$year/$semester/$studentName';
  http.Response response = await http.get(url);
  return jsonDecode(response.body);
}

Future getAttendance(String studentName, String year) async {
  print(
      "Initiated GetAttendance Request for studentName: $studentName ($year)");
  String url = '$server/attendance/$year/$studentName';
  http.Response response = await http.get(url);
  return jsonDecode(response.body);
}

Future getVideoByName(String name) async {
  print("\n==========Initiated VideoByName Request==========");
  String url = '$server/videobyname/$name';
  http.Response response = await http.get(url);
  return jsonDecode(response.body);
}

Future getCircularByid(String id) async {
  print("\n==========Initiated GetCircularByID Request==========");
  String url = '$server/circularbyid/$id';
  http.Response response = await http.get(url);
  Map<String, dynamic> body = jsonDecode(response.body)['response'];
  return {
    "id": body['id'].toString(),
    "grade": getGrade(body['grade']),
    "title": body['title'],
    "message": body['message'],
    "documentURI": body['documentURI'],
    "sent_date": convertTimeStamp(body['sent_date'])
  };
}

Future getCircularsByGrade(String grade) async {
  print("\n==========Initiated GetCircularsByGrade Request==========");
  String url = '$server/circularsbygrade/$grade';
  print("Starting With Grade: $grade");
  grade = "G$grade";
  http.Response response = await http.get(url);
  print("Fetched Server Response");
  List circulars = jsonDecode(response.body)['response'];
  print("Decoded Server Response");
  print(circulars);
  List<Map<String, String>> responseBody = [];
  print("Attempting Fusion");
  for (int i = 0; i < circulars.length; i++) {
    responseBody.add({
      "id": circulars[i]['id'].toString(),
      "title": circulars[i]['title'],
      "message": circulars[i]['message'],
      "documentURI": circulars[i]['documentURI'],
      "sent_date": convertTimeStamp(circulars[i]['sent_date'])
    });
    print("Appended Circular");
  }
  return responseBody;
}

Future getNotificationByid(String id) async {
  print("\n==========Initiated GetNotificationByID Request==========");
  String url = '$server/notificationbyid/$id';
  http.Response response = await http.get(url);
  Map<String, dynamic> body = jsonDecode(response.body)['response'];
  return {
    "id": body['id'].toString(),
    "grade": getGrade(body['grade']),
    "title": body['title'],
    "message": body['message'],
    "sent_date": convertTimeStamp(body['sent_date'])
  };
}

Future getNotificationsByGrade(String grade) async {
  print("\n==========Initiated GetNotificationsByName Request==========");
  String url = '$server/notificationsbygrade/$grade';
  print("Starting With Grade: $grade");
  grade = "G$grade";
  http.Response response = await http.get(url);
  print("Fetched Server Response");
  List notifications = jsonDecode(response.body)['response'];
  print("Decoded Server Response");
  List<Map<String, String>> responseBody = [];
  print("Attempting Fusion");
  for (int i = 0; i < notifications.length; i++) {
    responseBody.add({
      "id": notifications[i]['id'].toString(),
      "grade": getGrade(notifications[i]['grade']),
      "title": notifications[i]['title'],
      "message": notifications[i]['message'],
      "sent_date": convertTimeStamp(notifications[i]['sent_date'])
    });
    print("Appended Notification");
  }
  return responseBody;
}

Future getTopics(grade, subject) async {
  print("Initiated GetTopics Request");
  subject = convertSubject(subject);
  //Change Grade
  grade = grade != "ISC" ? "G$grade" : "ISC";
  String url = '$server/topics/$grade/$subject';
  http.Response response = await http.get(url);
  return jsonDecode(response.body);
}

class SubjectData {
  List<String> subjectThumbnailURI = [
    'assets/physics.png',
    'assets/chemistry.jpg',
    'assets/maths.png',
    'assets/biology.jpg',
    'assets/history.jpg',
    'assets/geography.jpg',
    'assets/eng1.jpg',
    'assets/eng2.jpg',
    'assets/secondlanguage.jpg',
    'assets/computer.jpg',
    'assets/physicaleducation.jpg',
  ];

  List<String> subjects = [
    'Physics',
    'Chemistry',
    'Mathematics',
    'Biology',
    'History & Civics',
    'Geography',
    'English Grammar',
    'English Literature',
    'Second Language',
    'Computer Science',
    'Physical Education'
  ];

  //Get Data
  List<String> getSubjectData(index) =>
      [subjects[index], subjectThumbnailURI[index]];

  //Retrieve Item Count
  int getCount() => subjects.length;
}
