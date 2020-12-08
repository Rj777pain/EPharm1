from flask import jsonify
from flask import request
from config import app
from config import mysql


#################################################################################
# checking user
@app.route('/user',methods=['POST'])
def user_check(): 
    try:
        
        conn = mysql.connect()        
        cursor = conn.cursor()
        json = request.get_json(force=True)
        pname = json['pname']
        
        cursor.execute("select * from patient where pname=%s;",pname)
        row_headers=[x[0] for x in cursor.description]
        empRows = cursor.fetchall()
        json_data=[]
        for r in empRows:
            json_data.append(dict(zip(row_headers,r)))
            # print(r)
        respone = jsonify(json_data)
        respone.status_code = 200
        return respone
        cursor.close()
        conn.close()
    except Exception as e:
        # print(e)
        message={
            'status':500,
            'message':'error in method',
        }
        print(message)
        respone = jsonify(message)
        respone.status_code = 500
        return respone
    finally:
        print("finished")

#################################################################################
# inserting prescription
@app.route('/in_pres',methods=['POST'])
def in_pres():
    try:
        
        conn = mysql.connect()        
        cursor = conn.cursor()
        
        json = request.get_json(force=True)
        doctor= json["doctor"]
        print(doctor)
        drug= json['drug']
        prid= json["prid"]
        pid= json["pid"]
        quantity= json["quantity"]
        print(drug)
        cursor.execute("insert into prescription(prid,drugid,pid,drid,quantity) values(%s,(select drugid from drugs where drugname=%s),%s,(select drid from doctor where drname=%s),%s);",(prid,drug,pid,doctor,quantity))
        conn.commit()

        cursor.execute("update prescription set price=quantity*(select price from drugs where drugs.drugid=prescription.drugid);")        
        conn.commit()
        
        message={
            'status':200,
            'message':'success',
        }
        respone = jsonify(message)
        respone.status_code = 200
        return respone
        cursor.close()
        conn.close()
    except Exception as e:
        # print(e)
        message={
            'status':500,
            'message':'error in method',
        }
        print(message)
        respone = jsonify(message)
        respone.status_code = 500
        return respone
    finally:
        print("finished")


#################################################################################
# inserting bill
@app.route('/in_bill',methods=['POST'])
def in_bill():
    try:
        conn = mysql.connect()        
        cursor = conn.cursor()
        json = request.get_json(force=True)
        prid = json['prid']
        cursor.execute("insert into bill(prid,phid,total,date) values(%s,101,(select sum(price) from prescription where prid=%s),curdate());",(prid,prid))
        conn.commit()
        message={
            'status':200,
            'message':'success',
        }
        respone = jsonify(message)
        respone.status_code = 200
        return respone
        cursor.close()
        conn.close()
    except Exception as e:
        # print(e)
        message={
            'status':500,
            'message':'error in method',
        }
        print(message)
        respone = jsonify(message)
        respone.status_code = 500
        return respone
    finally:
        print("finished")


#################################################################################
# getting current presciption id
@app.route('/max_p',methods=['POST'])
def maxp(): 
    try:
        
        conn = mysql.connect()        
        cursor = conn.cursor()
        
        # json = request.get_json(force=True)
        print("ss")
        cursor.execute("select max(prid) as max from prescription;",)
        
        row_headers=[x[0] for x in cursor.description]
        empRows = cursor.fetchall()
        json_data=[]
        for r in empRows:
            json_data.append(dict(zip(row_headers,r)))
            # print(r)
        respone = jsonify(json_data)
        respone.status_code = 200
        return respone
        cursor.close()
        conn.close()
    except Exception as e:
        # print(e)
        message={
            'status':500,
            'message':'error in method',
        }
        print(message)
        respone = jsonify(message)
        respone.status_code = 500
        return respone
    finally:
        print("finished")


#################################################################################
# fetching prescription
@app.route('/get_pres',methods=['POST'])
def get_pres():
    try:
        conn = mysql.connect()        
        cursor = conn.cursor()
        json = request.get_json(force=True)
        prid = json['prid']
        cursor.execute("select prescription.prid as prid,patient.pid as pid,drugname as drug,drname as doctor,quantity,prescription.price as price from prescription,drugs,doctor,patient where drugs.drugid=prescription.drugid and prescription.prid=%c and doctor.drid=prescription.drid and patient.pid=prescription.pid;",prid)
        row_headers=[x[0] for x in cursor.description]
        empRows = cursor.fetchall()
        json_data=[]
        for r in empRows:
            json_data.append(dict(zip(row_headers,r)))
            # print(r)
        respone = jsonify(json_data)
        respone.status_code = 200
        return respone
        cursor.close()
        conn.close()
    except Exception as e:
        # print(e)
        message={
            'status':500,
            'message':'error in method',
        }
        print(message)
        respone = jsonify(message)
        respone.status_code = 500
        return respone
    finally:
        print("finished")
    


#################################################################################
# fetching bill
@app.route('/get_bill',methods=['POST'])
def get_bill():
    try:
        conn = mysql.connect()        
        cursor = conn.cursor()
        json = request.get_json(force=True)
        prid = json['prid']
        cursor.execute("select phname as pharmacy,total from bill,pharmacy where bill.phid=pharmacy.phid and prid=%c;",prid)
        row_headers=[x[0] for x in cursor.description]
        empRows = cursor.fetchall()
        json_data=[]
        for r in empRows:
            json_data.append(dict(zip(row_headers,r)))
            # print(r)
        respone = jsonify(json_data)
        respone.status_code = 200
        return respone
        cursor.close()
        conn.close()
    except Exception as e:
        # print(e)
        message={
            'status':500,
            'message':'error in method',
        }
        print(message)
        respone = jsonify(message)
        respone.status_code = 500
        return respone
    finally:
        print("finished")
    

#################################################################################
# error handling
@app.errorhandler(404)
def not_found(error=None):
	message = {
		'status': 404,
		'message': 'Record not found: ' + request.url,
	}
	respone = jsonify(message)
	respone.status_code = 404
	return respone

if __name__ == "__main__":
    app.run(debug=True,host="192.168.43.19")