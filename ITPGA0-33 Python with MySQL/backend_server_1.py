"""
-- =================================================================
-- VIDEO STORE MANAGMENT SYSTEM
-- Python programming Project 1
-- Author:John Wesley Williams
-- Date: 2025/08/25-29
-- Purpose: To create a program that retrieves and alters data from a mysql database 
-- =================================================================

This will be the backend of the server
"""

import mysql.connector
from mysql.connector import Error
import json
import socket
import threading
from datetime import date

class VideoStoreServer:
    def __init__(self, host='localhost', port=12345):#this function connects the backend to the MySQL database
        self.host = host
        self.port = port
        self.socket = None
        self.db_config = {
            'user': 'root',
            'password': 'Password',
            'host': 'localhost',
            'database': 'video_store'}
    
    """Creating the database if it does not exists"""
    def db_setup(self):#this creates the tables in the database if they dont exist
        try:
            with self.get_connection() as conn:
                with conn.cursor() as cursor:
                    
                    #customer table
                    customer_table = """
                    CREATE TABLE IF NOT EXISTS customers 
                        (
                        custId INT AUTO_INCREMENT,
                    	fname VARCHAR(40) NOT NULL,
                    	sname VARCHAR(40) NOT NULL,
                        address VARCHAR(40) NOT NULL,
                    	phone VARCHAR(10) NOT NULL UNIQUE,
                    	PRIMARY KEY (custId) 
                        )"""
                    
                    cursor.execute(customer_table)
                    
                    #videos table
                    videos_table = """
                    CREATE TABLE IF NOT EXISTS videos 
                        (
                    	videoId INT NOT NULL,
                    	videoVer INT NOT NULL,
                    	vname VARCHAR(15) NOT NULL,
                    	type VARCHAR(1) NOT NULL,
                    	dateAdded DATE NOT NULL,
                    	PRIMARY KEY (videoId, videoVer)
                        )"""
                    cursor.execute(videos_table)
                    #hire_table
                    hire_table = """
                    CREATE TABLE IF NOT EXISTS hire 
                        (
                    	custId INT NOT NULL,
                    	videoId INT NOT NULL,
                    	videoVer INT NOT NULL,
                    	dateHired DATE NOT NULL,
                    	dateReturn DATE,
                    	FOREIGN KEY (custId) REFERENCES customers(custId),
                        FOREIGN KEY (videoId, videoVer) REFERENCES videos(videoId, videoVer)
                        )"""
                    cursor.execute(hire_table)
                    conn.commit()
        except Error as e:
            return {"status": "error", "message": str(e)}
                     
    def get_connection(self):#this code is used to allow functions to connect to the DB smotther
        """Function to establish a constant connection"""  
        return mysql.connector.connect(**self.db_config)

    def reg_customer(self, data):#this code registers customers
        """Function to register a new customer"""
        try:
            with self.get_connection() as conn:
               with conn.cursor(dictionary=True) as cursor:
                    #inserting the new customer into the customers table
                    query = """INSERT INTO customers (fname, sname, address, phone) 
                               VALUES (%s, %s, %s, %s)"""
                    cursor.execute(query, (data['fname'], data['sname'], data['address'], data['phone']))
                    conn.commit()
                    return {"status": "success", "message": "Customer successfully registered", "custId": cursor.lastrowid}
        except Error as e:
            return {"status": "error", "message": str(e)}

    def customer_exists(self, phone):#this code checks if the customer has already been registered by checking their phone number
        """Function to check if a customer already exists by using their phone number"""
        try:
            with self.get_connection() as conn:
                with conn.cursor(dictionary=True) as cursor:
                    #checking the customers table to see if the customer exists
                    query = "SELECT custId, CONCAT(fname, ' ', sname) AS customer FROM customers WHERE phone = %s"
                    cursor.execute(query, (phone,))
                    result = cursor.fetchone()
                    if result:
                        return {"status": "success", "exists": True, "customer": result}
                    else:
                        return {"status": "success", "exists": False, "message": "Customer does not exist"}
        except Error as e:
            return {"status": "error", "message": str(e)}

    def reg_movie(self, data):#this functions allos us to register movies
        """Function to register a new movie"""
        try:
            with self.get_connection() as conn:
                with conn.cursor(dictionary=True) as cursor:
                    #this finds the next available videoId and version
                    cursor.execute("SELECT MAX(videoId) as max_id FROM videos")
                    max_id_result = cursor.fetchone()
                    video_id = (max_id_result[0] or 0) + 1
                    
                    #if the movie has no previous version then the videoVer = 1
                    video_ver = 1
                    
                    query = """INSERT INTO videos(videoId, videoVer, vname, type, dateAdded) 
                               VALUES (%s, %s, %s, %s, %s)"""
                    cursor.execute(query, (video_id, video_ver, data['vname'], data['type'], date.today()))
                    conn.commit()
                    return {"status": "success", "message": "Movie successfully registered", "videoId": video_id}
        except Error as e:
            return {"status": "error", "message": str(e)}

    def movie_exists(self, videoId):#this is to check if a movie already exists
        """Function to check if movie is already registered"""
        try:
            with self.get_connection() as conn:
                with conn.cursor(dictionary=True) as cursor:  
                    query = """SELECT videoId, videoVer, vname 
                           FROM videos 
                           WHERE videoId = %s"""
                    cursor.execute(query, (videoId,))
                    result = cursor.fetchall()
                
                    if result:
                        #this tells us if the movie is avaialbe for hire
                        cursor.execute("""SELECT * FROM hire 
                                       WHERE videoId = %s AND dateReturn IS NULL""", (videoId,))
                        hired = cursor.fetchone()
                        available = hired is None
                        return {"status": "success", "exists": True, "available": available, "movies": result}  
                    else:
                        return {"status": "success", "exists": False, "message": "Movie is not registered"}  
        except Error as e:
            return {"status": "error", "message": str(e)}

    def hire_movie(self, data):#this tells us if a movie is available for hire
        """Function to hire movie"""
        try:
            with self.get_connection() as conn:
                with conn.cursor(dictionary=True) as cursor:
                    #first we check if the movie has already been hired by looking at the return date column
                    query = """SELECT * FROM hire
                               WHERE videoId = %s AND dateReturn IS NULL"""
                    cursor.execute(query, (data['videoId'],))
                    result = cursor.fetchone()
                    
                    if result:
                        return {"status": "error", "message": "Movie has already been rented"}
                    
                    cursor.execute("""SELECT videoVer FROM videos 
                              WHERE videoId = %s 
                              ORDER BY videoVer DESC LIMIT 1""", (data['videoId'],))
                    video_ver_result = cursor.fetchone()
               
                    if not video_ver_result:
                        return {"status": "error", "message": "Movie not found"}
                    video_ver = video_ver_result[0]
                    
                    #this adds a record to show which customer hired the video
                    query = """INSERT INTO hire(custId, videoId, videoVer, dateHired) 
                               VALUES (%s, %s, %s, %s)"""
                    cursor.execute(query, (data['custId'], data['videoId'], video_ver, date.today()))
                    conn.commit()
                    
                    return {"status": "success", "message": "Movie has been hired successfully"}
        except Error as e:
            return {"status": "error", "message": str(e)}

    def return_movie(self, data):#this function returns a hired movie
        """Function to return a movie"""
        try:
            with self.get_connection() as conn:
               with conn.cursor(dictionary=True) as cursor:
                    #first we find the record of the movie being hire by looking at its videoId and the return date
                    query = """SELECT * FROM hire
                               WHERE videoId = %s AND dateReturn IS NULL"""
                    cursor.execute(query, (data['videoId'],))
                    result = cursor.fetchone()
                    
                    if not result:
                        return {"status": "error", "message": "Movie has not been rented or already returned"}
                    
                    #once it has been returned we need to update the date return column to show it has been return for future customers
                    query = """UPDATE hire 
                               SET dateReturn = %s
                               WHERE videoId = %s AND dateReturn IS NULL"""
                    cursor.execute(query, (date.today(), data['videoId']))
                    conn.commit()
                    
                    return {"status": "success", "message": "Movie successfully returned"}
        except Error as e:
            return {"status": "error", "message": str(e)}

    def handle_client(self, client_socket):#this function will do all the heavy lifting in the python script
        """Function to handle client requests and action from the CLIENT-SERVER"""  
        try:
            #this is for if the client requests something
            request_data = client_socket.recv(4096).decode('utf-8')
            if not request_data:
                return
            
            try:
                data = json.loads(request_data)
                action = data.get('action')
                print(f"Processing action: {action}")
                #these are all the action a client can preform
                if action == 'reg_customer':
                    response = self.reg_customer(data)
                elif action == 'customer_exists':
                    response = self.customer_exists(data['phone'])
                elif action == 'reg_movie':
                    response = self.reg_movie(data)
                elif action == 'movie_exists':
                    response = self.movie_exists(data['videoId'])
                elif action == 'hire_movie':
                    response = self.hire_movie(data)
                elif action == 'return_movie':
                    response = self.return_movie(data)
                else:
                    response = {"status": "error", "message": "Unknown action"}
                
                print(f"Response: {response}")
                client_socket.send(json.dumps(response).encode())
                
            except json.JSONDecodeError as e:
                error_response = {"status": "error", "message": f"Invalid JSON: {str(e)}"}
                client_socket.send(json.dumps(error_response).encode())
                
        except Exception as e:
            error_response = {"status": "error", "message": f"Server error: {str(e)}"}
            client_socket.send(json.dumps(error_response).encode())
        finally:
            client_socket.close()

    def server_start_up(self):
        """Function to start up the server""" 
        try:
            #here was create the tables if they dont exists
            self.db_setup()
            
            #here we establishing a connection
            self.server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            self.server_socket.bind((self.host, self.port))
            self.server_socket.listen(5)
            print(f"Server started on {self.host}:{self.port}")
            
            while True:
                client_socket, addr = self.server_socket.accept()
                print(f"Connected to {addr}")
                threading.Thread(target=self.handle_client, args=(client_socket,), daemon=True).start()
                
        except Exception as e:
            print(f"Server error: {e}")
        finally:
            if self.server_socket:
                self.server_socket.close()

if __name__ == "__main__":
    server = VideoStoreServer()
    try:
        server.server_start_up()
    except KeyboardInterrupt:
        print("\nServer shutting down")
        if server.server_socket:
            server.server_socket.close()