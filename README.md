# **Todo app**

I have made this app with clean architecture and I used cubit as state management at the presentation layer.

## What you can do with this app

With this app ypu can add your todo list and what the time that this task will start on it. Then the app will remind you ahead of time for a number of minutes that you specify and you will more in the video : [video for the app](https://drive.google.com/drive/folders/1ZM1khCUl41XkvAvE1xh7gIaTrxYBGol4?usp=sharing)

## How does the app remind you?

Before the app upload the data to sqlite we transfer the startTime to DateTime variable the we subtract the number of minutes that we have choosen it. To understand more what i mean [check this](https://api.dart.dev/stable/2.10.5/dart-core/DateTime/subtract.html).

After I subtracted a head of minutes or an hour or a day from the date that i will send to the database. I put this in a DateTime variable and i splited it to hour and minutes as you will see in the next code and i set a notification. This notification will remind the user before the time that user decided.

### From peresentation\cubit\cubit.dart

```dart
NotificationService notificationService = NotificationService();
    DateTime date = DateFormat.jm()
        .parse(input.startTime.toString())
        .subtract(Duration(minutes: input.remind));
    var myTime = DateFormat('HH:mm').format(date);
    await notificationService
        .scheduleNotifications(
      time: input.startTime,
      repeat: input.repeat,
      body: input.title,
      hour: int.parse(myTime.toString().split(':')[0]),
      minute: int.parse(myTime.toString().split(':')[1]),
    )
```

If the user want the app to remind him daily this how i set this function to do this

### From core\services\notification.dart

```dart
  Future<void> scheduleNotifications({
    required int hour,
    required int minute,
    required String body,
    required String repeat,
    required String time,
  }) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      body,
      'You should $body at $time',
      _convertTime(hour, minute, repeat),
      NotificationDetails(
          android: _androidNotificationDetails, iOS: _iOSNotificationDetails),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  tz.TZDateTime _convertTime(int hour, int minutes, String repeat) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);
    if (scheduleDate.isBefore(now)) {
      if (repeat == 'Daily') {
        scheduleDate = scheduleDate.add(const Duration(days: 1));
      }
    }
    return scheduleDate;
  }
```

## Screenshots
<img src="https://github.com/MOHAB28/algoriza_phase_1/blob/main/screenshots/1.jpg" width="200" height="400" />
<img src="https://github.com/MOHAB28/algoriza_phase_1/blob/main/screenshots/2.jpg" width="200" height="400" />
<img src="https://github.com/MOHAB28/algoriza_phase_1/blob/main/screenshots/3.jpg" width="200" height="400" />
<img src="https://github.com/MOHAB28/algoriza_phase_1/blob/main/screenshots/4.jpg" width="200" height="400" />
<img src="https://github.com/MOHAB28/algoriza_phase_1/blob/main/screenshots/5.jpg" width="200" height="400" />
<img src="https://github.com/MOHAB28/algoriza_phase_1/blob/main/screenshots/6.jpg" width="200" height="400" />
<img src="https://github.com/MOHAB28/algoriza_phase_1/blob/main/screenshots/7.jpg" width="200" height="400" />
<img src="https://github.com/MOHAB28/algoriza_phase_1/blob/main/screenshots/8.jpg" width="200" height="400" />
