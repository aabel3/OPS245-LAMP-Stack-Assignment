# 🔧 Troubleshooting

Common Issues and Solutions

 # Problem 1: Can't connect to WordPress from host
Solutions:
+ Check firewall rules:
```
sudo iptables -L -v -n
```

+ Verify Apache is running:
```
sudo systemctl status apache2
```

+ Test from VM first:
```
lynx http://localhost/blog
```

# Problem 2: Database connection error
Solutions:
+ Verify database exists:
```
mysql -u root -p -e "SHOW DATABASES;"
```

+ Check WordPress config file has correct credentials

+ Ensure MariaDB is running:
```
sudo systemctl status mariadb
```

# Problem 3: Static IP not working
Solutions:
+ Check netplan syntax:
```
sudo netplan try
```
+ Verify interface name matches:
```
ip address
```
+ Apply again:
```
sudo netplan apply
```

# Problem 4: Hostname resolution not working
Solutions:
+ Check /etc/hosts on both VM and host

+ Ensure format is correct:
```
  hostname
```

+ Test with ping:
```
ping username-ubuntu
```

# Problem 5: Apache test page shows but not WordPress
Solutions:
+ Verify WordPress site is enabled:
```
ls /etc/apache2/sites-enabled/
```

+ Check Apache error logs:
```
sudo tail -f /var/log/apache2/error.log
```

Restart Apache: 
```
sudo systemctl restart apache2
```
