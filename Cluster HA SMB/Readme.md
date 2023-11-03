#### Config dos nodes para as instalação


Server1, Server2, Server3
**Configurar senha para o root**   
```shell
sudo passwd root
```

Server1, Server2, Server3
Edite o seguinte arquivo: **/etc/ssh/sshd_config**    
```shell
sudo nano /etc/ssh/sshd_config
```  
Modifique a linha:   
```shell
PermitRootLogin no 
```   
Para:   
```shell 
PermitRootLogin yes
```   
Server1, Server2, Server3
**Agora reinicie o serviço de ssh:***
```shell
sudo systemctl restart ssh
```   

No server1 verificar a ligação

Server1
```shell
ssh root@Ip2
ssh root@Ip3
```  

