import 'dart:convert';

class Pres {
    Pres({
        this.doctor,
        this.drug,
        this.price,
        this.prid,
        this.pid,
        this.quantity,
    });

    String doctor;
    String drug;
    int price;
    int prid;
    int pid;
    int quantity;

    factory Pres.fromJson(String str) => Pres.fromMap(json.decode(str));
    
    String toJson() => json.encode(toMap());

    factory Pres.fromMap(Map<String, dynamic> json) => Pres(
        doctor: json["doctor"],
        drug: json["drug"],
        price: json["price"],
        prid: json["prid"],
        pid: json["pid"],
        quantity: json["quantity"],
    );

    Map<String, dynamic> toMap() => {
        "doctor": doctor,
        "drug": drug,
        "price": price,
        "prid": prid,
        "pid": pid,
        "quantity": quantity,
    };
}