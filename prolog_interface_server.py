# coding=utf-8
#!/usr/bin/env python3

from pyswip import Prolog
import socket
import time

HOST = '127.0.0.1'  # Standard loopback interface address (localhost)
PORT = 3344        # Port to listen on (non-privileged ports are > 1023)

def main():
    prolog = Prolog()
    prolog.consult("main.pl")

    print("Prolog Interface Server")
    while True:
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.bind((HOST, PORT))
            s.listen()
            conn, addr = s.accept()
            with conn:
                print('Connected by', addr)
                while True:
                    data = conn.recv(1024)
                    if not data:
                        break
                    print (data)
                    for nlp_parser in prolog.query(data):
                        print(nlp_parser["P"])
                        conn.sendall(nlp_parser["P"])
                        time.sleep(0.001)
                    conn.sendall(b'Finish')
main()
