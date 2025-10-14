"""
-- =================================================================
-- VIDEO STORE MANAGMENT SYSTEM
-- Python programming Project 1
-- Author:John Wesley Williams
-- Date: 2025/08/25-29
-- Purpose: To create a program that retrieves and alters data from a mysql database 
-- =================================================================

This will be the frontend of the server providing a user friendly interface
"""


import socket
import json

class VideoStoreClient:
    def __init__(self, host='localhost', port=12345):
        self.host = host
        self.port = port
        self.socket = None
        
    def connection_to_server(self):#this function connects the frontend of the server to the backend
        """Establishing a connection between the to servers"""
        try:
            self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            self.socket.connect((self.host, self.port))
            print("Connected to server successfully")
            return True
        except Exception as e:
            print(f"Unable to connect to server: {e}")
            return False
    
    def send_request(self, data):
        """Send request to server and get response"""
        try:
            #this would be the frontend sending a request to the backend
            request_json = json.dumps(data)
            self.socket.send(request_json.encode('utf-8'))
            
            #this would be the responce sent from the backend
            response_data = self.socket.recv(4096).decode('utf-8')
            return json.loads(response_data)
            
        except Exception as e:
            return {"status": "error", "message": f"Communication error: {str(e)}"}
    
    def main_menu(self):#this function will display the main menu customers see once they are in the store
        """This will display the menu that customers will see"""
        print("\n" + "="*50)
        print("        VIDEO STORE MANAGEMENT SYSTEM")
        print("="*50)
        print("1. Register Customer")
        print("2. Register Movie")
        print("3. Hire Movie")
        print("4. Return Movie")
        print("5. Exit System")
        print("="*50)
        
    def user_input(self, prompt, input_type=str, max_length=None):#this functions sets perameters so only specific data can be inserted
        """This function will allow other functions to get user inputs repeatedly"""
        while True:
            try:
                user_input = input(prompt).strip()
                
                if not user_input:
                    print("Input cannot be empty. Please try again.")
                    continue
                
                if max_length and len(user_input) > max_length:
                    print(f"Input is too long (max {max_length} characters). Please try again.")
                    continue
                
                if input_type == int:
                    try:
                        return int(user_input)
                    except ValueError:
                        print("Please enter a valid number.")
                        continue
                else:
                    return user_input
                    
            except KeyboardInterrupt:
                print("\nSection cancelled.")
                return None
            except Exception as e:
                print(f"Error: {e}. Please try again.")
    
    def reg_customer(self):#this function talks to the reg customer function in the backend
        """Function to handle a customer registering"""
        print("\n--- REGISTER CUSTOMER ---")
        
        #first we get the customers phone number to check if the customer is already registered
        phone = self.user_input("Enter Customer Phone Number (10 Digits): ", str, 10)
        if phone is None:
            return
        
        #then we check and see if its given in the correct format or datatype
        if not phone.isdigit() or len(phone) != 10:
            print("Invalid input. Please enter a phone number with exactly 10 digits.")
            return
        
        #now we check if the customer already exist
        request = {"action": "customer_exists", "phone": phone}
        response = self.send_request(request)
        
        if response.get('status') == 'error':
            print(f"Error: {response.get('message', 'Unknown error')}")
            return
        
        if response.get('exists'):
            print("Customer already exists.")
            print(f"Customer ID: {response['customer']['custId']}, Name: {response['customer']['customer']}")
            return
        
        #this is to input the customers details
        print("Customer does not exist. Please enter details:")
        fname = self.user_input("Enter first name: ", str, 40)
        sname = self.user_input("Enter surname: ", str, 40)
        address = self.user_input("Enter address: ", str, 40)
        if fname is None: return
        if sname is None: return
        if address is None: return

        #now we input the customers details into the customer table
        request = {
            "action": "reg_customer",
            "fname": fname,
            "sname": sname,
            "address": address,
            "phone": phone
        }
        
        response = self.send_request(request)
        
        if response.get('status') == 'error':
            print(f"Error: {response.get('message', 'Unable to register customer')}")
        else:
            print(f"Customer registered successfully! Customer ID: {response.get('custId')}")
    
    def reg_movie(self):#this function registers new movies that are old and new
        """This functions is for registering a movie"""
        print("\n--- REGISTER MOVIE ---")
        
        vname = self.user_input("Enter movie name: ", str, 40)
        if vname is None:
            return
        
        print("Movie Types:\nR - Red box – new movies\nB - Black box – old movies")
        
        while True:
            type = self.user_input("Enter movie type (R/B): ", str)
            if type is None:
                return
            if type.upper() in ['R', 'B']:
                break
            print("Invalid movie type. Please enter R or B.")
        
        #here we input the new movie details into the videos table
        request = {
            "action": "reg_movie",
            "vname": vname,
            "type": type.upper(),
        }
        
        response = self.send_request(request)
        
        if response.get('status') == 'error':
            print(f"Error: {response.get('message', 'Unable to register movie')}")
        else:
            print(f"Movie registered successfully! Video ID: {response.get('videoId')}")
    
    def hire_movie(self):#this function is used to hire a film will the customers phone number as validation
        """Function to hire out a movie"""
        print("\n--- HIRE MOVIE ---")
        
        #this is to check if the customer already exists
        phone = self.user_input("Enter Customer Phone Number (10 Digits): ", str, 10)
        if phone is None:
            return
        
        if not phone.isdigit() or len(phone) != 10:
            print("Invalid phone number format.")
            return
        
        request = {"action": "customer_exists", "phone": phone}
        response = self.send_request(request)
        
        if response.get('status') == 'error':
            print(f"Error: {response.get('message', 'Unknown error')}")
            return
        
        if not response.get('exists'):
            print("Customer does not exist. Please register first.")
            return
        
        cust_id = response['customer']['custId']
        
        #to check if the movie is avaiable for hire
        video_id = self.user_input("Enter video ID of requested movie: ", int)
        if video_id is None:
            return
        
        request = {"action": "movie_exists", "videoId": video_id}
        response = self.send_request(request)
        
        if response.get('status') == 'error':
            print(f"Error: {response.get('message', 'Unknown error')}")
            return
        
        if not response.get('exists'):
            print("Movie is not registered.")
            return
        
        if not response.get('available'):
            print("Movie is currently rented out and not available.")
            return
        
        print("Movie is available for hire.")
        
        # Hire the movie
        request = {
            "action": "hire_movie",
            "custId": cust_id,
            "videoId": video_id
        }
        
        response = self.send_request(request)
        
        if response.get('status') == 'error':
            print(f"Error: {response.get('message', 'Unable to hire movie')}")
        else:
            print("Movie hired successfully!")
    
    def return_movie(self):#this is used to return a hired movie
        """Function to return a movie that has been hired"""
        print("\n--- RETURN MOVIE ---")
        
        video_id = self.user_input("Enter video ID of movie to return: ", int)
        if video_id is None:
            return
        
        request = {"action": "return_movie", "videoId": video_id}
        response = self.send_request(request)
        
        if response.get('status') == 'error':
            print(f"Error: {response.get('message', 'Unable to return movie')}")
        else:
            print("Movie returned successfully!")
    
    def main_function(self):#this function does the heavily lifting of the frontend of the server
        """This will be the function that runs all the other functions while on a loop"""
        if not self.connection_to_server():
            print("Unable to connect to main server.")
            return
        
        print("Video store client connected to main server")
        
        try:
            while True:
                self.main_menu()
                
                try:
                    choice = input("\nEnter choice (1-5): ").strip()
                    
                    if choice == '1':
                        self.reg_customer()
                    elif choice == '2':
                        self.reg_movie()
                    elif choice == '3':
                        self.hire_movie()
                    elif choice == '4':
                        self.return_movie()
                    elif choice == '5':
                        print("Thank you for using the VIDEO STORE MANAGEMENT SYSTEM\nGoodbye!")
                        break
                    else:
                        print("Invalid choice. Please enter a number between 1 and 5.")
                        
                except KeyboardInterrupt:
                    print("\nOperation cancelled.")
                except Exception as e:
                    print(f"\nError: {e}. Please try again.")
                    
        finally:
            if self.socket:
                self.socket.close()
                print("Connection closed.")

if __name__ == "__main__":
    client = VideoStoreClient()
    client.main_function()