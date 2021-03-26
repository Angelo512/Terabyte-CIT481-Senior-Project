## **Installing The Apache Web Service On A EC2 Instance Using Ansible Playbook**

Inside this folder there are three files that we will need: 
- `proj0_web_server.yml`
- `hosts.ini`
- `index.html`

**proj0_web_server.yml**: This is the ansible .yml file that will install the apache2 service and re-write the default index.html file

**hosts.ini**: This is host file that will hold the ip address of the ec2 instance we will connect to 

**index.html**: This is the new index.html file that we will add to our instance which contains our team name and the names of all our team members 

---

### **Prerequisites**

1. A Linux Bash Terminal
2. Installation of Ansible 
3. An AWS Account 
4. Internet Connection

---

### **Before We Begin**

On your bash terminal, make sure that you have [Ansible](https://docs.ansible.com/ansible/latest/index.html) installed, you can check by entering the following command: 

``` bash
$ ansible --version
```

If not simply run this command: 

``` bash 
$ apt update && apt install -y ansible
``` 
On AWS: 
1. create an ec2 ubuntu instance 
2. choose all the free options (You do not have to) 
3. Add two security groups: **ssh and http (or https)**
4. Create a new **.pem key**

**NOTE: Make sure to remember the location of that .pem file**

---

### Step 1: Prep The EC2 Instance

After launching the ec2 instance through the AWS console use your bash terminal to ssh into it: 


First things first, change the permissions of that .pem key file that is associated with your ec2 instance: 

``` bash
$ chmod 400 .../NAMEOFFILE.pem
``` 
<ins>NOTE: add the full path and name of your .pem file</ins>


Now we can connect to ec2 instance using our bash terminal with the following command, preferably run it within the same directory where your .pem file is stored otherwise you will have to add the full path to the .pem file: 

``` bash
ssh -i "NAMEOFFILE.pem" ubuntu@IP-ADDRESS-OF-INSTANCE
```

<ins>Replace the NAMEOFFILE.pem with your actual .pem file and replace IP-ADDRESS with your ec2 instance's public IP.</ins>


Once you are logged into your instance you will need to run install python3 as it is needed to run an ansible playbook on it: 

``` bash
$ sudo apt update 
```

And finally, lets check if python3 is installed: 

``` bash
$ python3 --version
```

Once it is installed now we can move foward to prepping the ansible playbook

---

### Step 2: The Ansible-PlayBook Folder 

This folder has three files: 
1. The ansible .yml file 
2. The index.html file
3. The hosts.ini file 

You will need to download these files and save them within the same directory, name this new directory: Proj0-Ansible

<ins>It should look this within your local machine</ins>

- `Proj0-Ansible`
	- `proj0_web_server.yml`
	- `hosts.ini`
	- `index.html`


Now you will need to edit these files to suite your environment


**proj0_web_server.yml**

Only one edit is needed here and that is to fill in the location of `index.html` file within your local machine

Traverse to the second task in the code and go to this line:

`src: /[PATH]/Proj0-Ansible/index.html`

Replace `[PATH]` with the full path of `Proj0-Ansible/index.html` within your local machine 

Once you have added it the full path just save the file and move on to the hosts.ini file


**hosts.ini**

Now for this file, all you have to do is delete the mock IP Address and add the IP Address of your ec2 instance 

---

### Step 3: Running The Ansible PlayBook

**NOTE: Before running the ansible playbook make sure that you instance is running**

Open a new bash terminal and from **with in** the `Proj0-Ansible` directory **run this command:**

``` bash
$ ansible-playbook -i hosts.ini proj0_web_server.yml -u ubuntu --key-file .../NAMEOFFILE.pem
```
<ins>**NOTE**: Make sure to replace .../NAMEOFFILE.pem with the full path and name of .pem key file that corresponds with the ec2 instance which IP Address is listed within the hosts.ini</ins>

---

### Step 4: The Results 

Now to find out if ansible playbook was successfull you can look at the provided output and/or you can view the /var/www/index.html file or enter the ip address of your ec2 instance in your browser. 

If it was successfull you should see the team name and team members html page rather than the default index.html provided with each new installation of the apache2 service

---

### **RESOURCES**
- [Ansible Documentation](https://docs.ansible.com/ansible/latest/index.html)
