# 🔧 Troubleshooting

Common Issues and Solutions

 # Problem 1: Can't connect to WordPress from host
Solutions:
+ Check firewall rules:
bash
```
sudo iptables -L -v -n
```

+ Verify Apache is running:
bash
```
sudo systemctl status apache2
```

+ Test from VM first:
bash
```
lynx http://localhost/blog
```

# Problem 2: Database connection error
Solutions:
+ Verify database exists:
bash
```
mysql -u root -p -e "SHOW DATABASES;"
```

+ Check WordPress config file has correct credentials

+ Ensure MariaDB is running:
bash
```
sudo systemctl status mariadb
```

# Problem 3: Static IP not working
Solutions:
+ Check netplan syntax:
bash
```
sudo netplan try
```
+ Verify interface name matches:
bash
```
ip address
```
+ Apply again:
bash
```
sudo netplan apply
```

# Problem 4: Hostname resolution not working
Solutions:
+ Check /etc/hosts on both VM and host

+ Ensure format is correct:
bash
```
  hostname
```

+ Test with ping:
bash
```
ping username-ubuntu
```

# Problem 5: Apache test page shows but not WordPress
Solutions:
+ Verify WordPress site is enabled:
bash
```
ls /etc/apache2/sites-enabled/
```

+ Check Apache error logs:
bash
```
sudo tail -f /var/log/apache2/error.log
```

Restart Apache: 
bash 
```
sudo systemctl restart apache2
```
