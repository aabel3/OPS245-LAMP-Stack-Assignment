# Initial Setup

# Step 1: Create New Ubuntu VM
VM Specifications:
+ VM Name: username-ubuntu (replace with your Seneca username)
+ Hostname: Same as VM name
+ Installation: Full GUI (not minimal)
<img width="1365" height="726" alt="1" src="https://github.com/user-attachments/assets/5c787bfd-b70f-426c-863a-c2f29abf34f2" />

# Step 2: Set Ubuntu to Boot in CLI Mode
+ After installation, configure the system to boot into command-line interface:
```
sudo systemctl set-default multi-user.target
```
+ Reboot to apply changes:
```
sudo reboot
```
+ Alternative (without reboot):
```
sudo systemctl isolate multi-user.target
```
<img width="1365" height="726" alt="2" src="https://github.com/user-attachments/assets/2d110cbc-9e91-4ca6-8d72-c1ed34f15261" />

+ To help verify use the command:
```
systemctl get-default
```

# Step 3: Configure Static IP
+ Edit the netplan configuration file:
```
sudo vim /etc/netplan/99_config.yaml
```
+ or use nano:
```
sudo nano /etc/netplan/99_config.yaml
```

+ Check your network interface name first:
```
ip a
```
<img width="1365" height="729" alt="4" src="https://github.com/user-attachments/assets/6aee7239-f72f-49df-91ec-6c3505240c79" />

+ Look for interface name (usually enp1s0, enp0s3, etc.)
+ Add this configuration (replace enp1s0 with your interface name):
``` yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    enp1s0:
      addresses:
        - 192.168.245.5/24
      routes:
        - to: default
          via: 192.168.245.1
      nameservers:
        addresses: [192.168.245.1]
```
<img width="1365" height="729" alt="3" src="https://github.com/user-attachments/assets/4b5424e8-af45-4156-925f-ea240254583c" />

+ Apply the configuration:
```
sudo netplan apply
```

+ Verify the IP:
```
ip address
```
<img width="1365" height="729" alt="4" src="https://github.com/user-attachments/assets/3e507548-b49c-437b-87f1-6babb15bcae3" />

# Step 4: Configure Hostname Resolution
+ Edit /etc/hosts on both your Ubuntu VM and host machine:
```
sudo vim /etc/hosts
```
+ Add this line:
```
192.168.245.5   <username>-ubuntu
```
<img width="1365" height="727" alt="5" src="https://github.com/user-attachments/assets/78428107-5553-4ad5-ad78-ece3338b0e32" />

+ Test connectivity:
```
ping 192.168.245.1
```

+ Test internet
```
ping google.com
```

+ Test hostname resolution
```
ping <username>-ubuntu
```
<img width="1365" height="728" alt="6" src="https://github.com/user-attachments/assets/e0135891-c72f-49b2-b63b-52fceaaa5f18" />

# Step 5: Update System and Install Packages
Update package lists:
```
sudo apt update && sudo apt upgrade
```
<img width="1365" height="730" alt="7" src="https://github.com/user-attachments/assets/4b29a1dd-c7f9-4967-9df3-9d66f6dd47b8" />

+ Install required packages:
bash
```
sudo apt install apache2 php php-mysql mariadb-server wordpress nftables
```
<img width="1365" height="726" alt="8" src="https://github.com/user-attachments/assets/8c49ce02-a846-4ceb-86e8-5da9fad49466" />


+ Optional - Install lynx for testing:
```
sudo apt install lynx
```

# Step 6: Switch from UFW to NFTables
+ Stop and disable UFW:
```
sudo systemctl stop ufw
sudo systemctl disable ufw
```
<img width="1365" height="730" alt="10" src="https://github.com/user-attachments/assets/6a3c71d0-2d11-412c-a36c-c0177ff88f68" />

+ Enable and start NFTables:
```
sudo systemctl start nftables
sudo systemctl enable nftables
```

# Step 7: Configure Firewall Rules
+ Find required ports:
```
grep http /etc/services | head
```
+ Find SSH port
grep ssh /etc/services | head
<img width="1365" height="727" alt="11" src="https://github.com/user-attachments/assets/b7dabac6-ac37-46f2-bf8c-7738ffaf216e" />

+ Add firewall rules:
```
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT # Allow HTTP traffic (port 80)
```

```
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT # Allow SSH traffic (port 22)
```

```
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT # Allow established connections
```

```
sudo iptables -A INPUT -p udp --dport 53 -j ACCEPT # Allow DNS for apt
```

```
sudo iptables -P INPUT DROP # Set default policy to DROP
```
<img width="1365" height="727" alt="12" src="https://github.com/user-attachments/assets/a6ca231b-913f-4865-9d2d-5e3d4cf66937" />

+ Save firewall configuration:
```
sudo iptables-save | sudo tee /etc/iptables/rules.v4
```

+ Verify rules:
```
sudo iptables -L -v -n
```
<img width="1365" height="726" alt="13" src="https://github.com/user-attachments/assets/7f7081cb-1212-4866-bbec-8c9b4e943636" />

# Step 8: Configure Apache Web Server
+ Check Apache status:
```
sudo systemctl status apache2
```

+ Enable Apache to start on boot:
```
sudo systemctl enable apache2
```

+ Start Apache if not running:
```
sudo systemctl start apache2
```
<img width="1365" height="729" alt="14" src="https://github.com/user-attachments/assets/dda05a91-8bb5-4531-b410-a3690a6a64ee" />

# Step 9: Test Apache
Test from Ubuntu VM:
```
lynx http://localhost
```
alternatively:
```
lynx http://192.168.245.5
```
<img width="1365" height="730" alt="15" src="https://github.com/user-attachments/assets/8abaadb4-e0d3-4f07-ad83-6f912f63b87d" />

+ Test from host machine:
  - Open Firefox
  - Navigate to: http://192.168.245.5
  - You should see the Apache2 Ubuntu Default Page
<img width="1365" height="726" alt="16" src="https://github.com/user-attachments/assets/d8413ce4-aef6-472c-ab3a-5f6b8a0eaaff" />

# Step 10: Configure MariaDB
+ Check MariaDB status:
```
sudo systemctl status mariadb
sudo systemctl enable mariadb
sudo systemctl start mariadb
```
<img width="1365" height="727" alt="17" src="https://github.com/user-attachments/assets/e31f5613-0a77-48ae-9fd0-aff34b7866cf" />

# Step 11: Secure MariaDB Installation
+ Run the security script:
```
sudo mysql_secure_installation
```
+ Follow these prompts:
  - Enter current password for root: **(press Enter - no password initially)**
  - Switch to unix_socket authentication? **N**
  - Change root password? **Y**
  - New password: **(your-seneca-username)**
  - Remove anonymous users? **Y**
  - Disallow root login remotely? **Y**
  - Remove test database? **Y**
  - Reload privilege tables? **Y**
<img width="1365" height="728" alt="18" src="https://github.com/user-attachments/assets/8f1e1e9d-7d3b-418b-8abd-f5e99bae295f" />

# Step 12: Create WordPress Database and User
+ Connect to MariaDB:
```
mysql -h localhost -u root -p
```
+ Enter your Seneca username as password
<img width="1365" height="724" alt="19" src="https://github.com/user-attachments/assets/011d274b-e2be-4ec0-babe-a80459d8b90a" />

+ Create database:
``` sql
CREATE DATABASE myblog;
```

```sql
CREATE USER username@localhost IDENTIFIED BY 'username';
```
```sql
GRANT ALL PRIVILEGES ON myblog.* TO username@localhost IDENTIFIED BY 'username';
```

```sql
FLUSH PRIVILEGES;
```

``` sql
exit;
```
<img width="1365" height="729" alt="20" src="https://github.com/user-attachments/assets/b218e268-7431-455d-b299-f8833e03cd72" />

+ Verify database creation:
```
mysql -h localhost -u root -p -e "SHOW DATABASES;"
```
<img width="1365" height="728" alt="21" src="https://github.com/user-attachments/assets/0960c253-4456-4063-9618-034c57fb0f9a" />

# Step 13: Create Apache Virtual Host
+ Create WordPress configuration file:
```
sudo vim /etc/apache2/sites-available/wordpress.conf
```
+ Add this content:
``` apache
Alias /blog /usr/share/wordpress
<Directory /usr/share/wordpress>
    Options FollowSymLinks
    AllowOverride Limit Options FileInfo
    DirectoryIndex index.php
    Order allow,deny
    Allow from all
</Directory>
<Directory /usr/share/wordpress/wp-content>
    Options FollowSymLinks
    Order allow,deny
    Allow from all
</Directory>
```
<img width="1365" height="727" alt="22" src="https://github.com/user-attachments/assets/eec155b5-a967-41af-8c7c-08bafdf0e510" />

+ Enable the WordPress site:
```
sudo a2ensite wordpress
```

+ Restart Apache:
```
sudo systemctl restart apache2
```
<img width="1365" height="725" alt="23" src="https://github.com/user-attachments/assets/e0a29cb1-be1f-4f2d-b63c-b3b2dd1319dd" />

# Step 14: Configure WordPress Database Connection
+ Create WordPress config file (replace username with your Seneca username):
```
sudo vim /etc/wordpress/config-username-ubuntu.php
```
+ Add this content (replace username with your Seneca username):
``` php
<?php
define('DB_NAME', 'myblog');
define('DB_USER', 'username');
define('DB_PASSWORD', 'username');
define('DB_HOST', 'localhost');
define('WP_CONTENT_DIR', '/usr/share/wordpress/wp-content');
?>
```
<img width="1365" height="724" alt="24" src="https://github.com/user-attachments/assets/2dae5cd9-b04b-4535-9112-5ae0ec34a6f2" />

# Step 15: Complete WordPress Installation
+ Open browser on host machine and navigate to: http://username-ubuntu/blog/wp-admin/install.php
(Replace username with your actual username)
<img width="1365" height="726" alt="25" src="https://github.com/user-attachments/assets/1e1fc655-5f12-4e46-ae66-1a6bade4cfdb" />

+ Fill in the installation form:
  - Site Title: Your Name's Blog (e.g., "Avraham Abel's Blog")
  - Username: Your Seneca ID
  - Password: Your Seneca ID
  - Check "Confirm use of weak password" if needed
  - Email: Your Seneca email address
<img width="1365" height="726" alt="26" src="https://github.com/user-attachments/assets/caa7e68e-2d6e-46d4-bd09-d911e0fe07ef" />

+ Click "Install WordPress"
<img width="1365" height="729" alt="28" src="https://github.com/user-attachments/assets/4839b4b1-9c2a-49df-a35d-9404f1b1b8b9" />

# Step 16: Write Required Blog Posts
+ Login to WordPress: http://username-ubuntu/blog/wp-admin
<img width="1365" height="727" alt="30" src="https://github.com/user-attachments/assets/132ce7f9-485f-4fda-8939-184a64f1b550" />

+ First Blog Post: Technical Overview
  - Title: "LAMP Stack Components and Installation Journey"
Content should include:
    - What is Apache? - Explain it's a web server
    - What is PHP? - Server-side scripting language
    - What is MySQL/MariaDB? - Database management system
    - What is WordPress? - Content management system
    - Problems encountered - Document any issues you faced
    - Solutions - How you resolved them

+ Second Blog Post: Exam Preparation
  - Title: "Exam Readiness Self-Assessment"
Content should include:
    - Your exam readiness status
    - Material you're confident about
    - Topics you need to review
    - Questions for exam review

# Step 17: Run Check Script
+ Install git (if needed):
```
sudo apt install git
```

+ Download the check script:
```
git clone https://github.com/jmcarman/a2-check
```

```
cd a2-check
```

+ Make script executable and run:
```
chmod +x marka2.bash
```

```
./marka2.bash
```

# Step 18: Gather Screenshots
Create a document named yourusername-a2.pdf or .docx containing:
+ ✅ CLI mode (multi-user.target)
+ ✅ Static IP configuration
+ ✅ NFTables rules
+ ✅ Apache status and test page
+ ✅ MariaDB status and database
+ ✅ WordPress configuration files
+ ✅ WordPress showing in Firefox
+ ✅ Blog accessed via hostname
+ ✅ First blog post (OPTIONAL - crossed out in rubric)
+ ✅ Second blog post
+ ✅ Output from check script (a2output.txt)

# Step 19: Submit on Blackboard
Upload your document to the Assignment 2 folder on Blackboard.
