# CCDC Playbook
# **REMEMBER TO CHANGE PASSWORDS**
``` bash
passwrd #changes password
```

# Survelliance Commands

```bash
sudo systemctl list-units --type=service #For services
```
```bash
sudo ps -ef | [grep/less] #For active services
```
```bash
sudo ss -tulnp #For ports
```
```bash
who #For ssh
```

# Kill Commands
```bash
sudo kill [-9] <PID> #Kill command based on PID
```
```bash
sudo systemctl disable [service] --now #Stop service on bootup
```
```bash
sudo systemctl stop [service] #Stop service (still works on bootup)
```
```bash
sudo pkill -9 -t [shell] #for disconnecting ssh users
```
