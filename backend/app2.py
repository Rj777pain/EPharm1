from flask import jsonify
from flask import request
from config import app
from config import mysql

@app.route('/aaa',methods=['POST'])
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