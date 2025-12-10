# OPS245 Assignment 2 – LAMP Stack & WordPress Deployment

Welcome to OPS445 Assignment 2!

In this assignment, you will install and configure a LAMP stack (Linux, Apache, MariaDB, PHP) inside a new Ubuntu VM. You will then use this platform to host WordPress, configure firewall rules with nftables, and document your work through screenshots and blog posts.

# 📚 Assignment Objectives:
+ Create a new Ubuntu VM (username-ubuntu) and set it to boot into CLI (multi-user.target)
+ Configure a static IP and hostname resolution
+ Install and configure the following packages:
  - apache2 (web server)
  - php and php-mysql (server-side scripting and database integration)
  - mariadb-server (database engine)
  - wordpress (CMS application)
  - nftables (firewall)
+ Configure nftables firewall rules to allow HTTP, SSH, and apt traffic while dropping all other traffic
+  Verify Apache and MariaDB services are running and enabled at boot
+ Configure WordPress with a dedicated database and user
+ Access WordPress via browser and complete the setup wizard
+ Write two professional blog posts on your new WordPress site

# 📂 Assignment Files & Deliverables:
You will create and work with the following during this assignment:
+ /etc/netplan/99_config.yaml – Static IP configuration
+ /etc/hosts – Local hostname resolution
+ Firewall rules configured via nftables
+ /etc/apache2/sites-available/wordpress.conf – WordPress virtual host configuration
+ /etc/wordpress/config-<username>-ubuntu.php – WordPress database configuration
+ Blog posts:
  - Post 1: Explanation of Apache, PHP, MySQL/MariaDB, and WordPress + installation issues/resolutions
  - Post 2: Exam readiness reflection (strengths, weaknesses, questions)
+ a2output.txt – Output from the assignment check script
+ Screenshots showing proof of each rubric item

# 🧩 Tips & Tricks:
+ Use systemctl isolate multi-user.target to switch to CLI mode without rebooting.
+ Always test network connectivity with ping before proceeding.
+ Use grep http /etc/services and grep ssh /etc/services to confirm required ports for firewall rules.
+ Run sudo mysql_secure_installation carefully to secure MariaDB before creating the WordPress database.
+ Use lynx inside the VM and Firefox on the host to test Apache and WordPress connectivity.
+ Keep your blog posts professional—use headings, lists, and proper grammar.

# 📖 References:
+ Assignment 2 Check Script Repository (https://github.com/jmcarman/a2-check)

# ✅ Rubric (20 Marks):
| Task | Marks |
|------|-------|
| System set to boot in CLI | 1 |
| Static IP applied | 2 |
| nftables installed and configured | 2 |
| Apache configured and running | 3 |
| MariaDB configured and running | 3 |
| WordPress configured correctly | 3 |
| WordPress accessible in Firefox | 1 |
| Blog accessed via hostname resolution | 1 |
| First blog post | 1 |
| Second blog post | 1 |
| Submitted correctly | 2 |
| Total | 20 |
