
import 'dart:convert';

class User {
    User({
        this.age,
        this.contact,
        this.pid,
        this.pname,
        this.sex,
    });

    int age;
    int contact;
    int pid;
    String pname;
    String sex;

    factory User.fromJson(String str) => User.fromMap(json.decode(str)[0]);

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        age: json["age"],
        contact: json["contact"],
        pid: json["pid"],
        pname: json["pname"],
        sex: json["sex"],
    );

    Map<String, dynamic> toMap() => {
        "age": age,
        "contact": contact,
        "pid": pid,
        "pname": pname,
        "sex": sex,
    };
}
