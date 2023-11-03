#### Config dos nodes para as instalação


Server1, Server2, Server3
**Configurar senha para o root**   
```shell
sudo passwd root
```
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

**Agora reinicie o serviço de ssh:***
```shell
sudo systemctl restart ssh
```   
