## **Using Ansible To Configure Our Private EC2 Instances Using Our Bastion Host**

Inside this folder: 
- `aws_ec2.yml`
- `index.html`
- `proj1_main.yml`
- `proj1_service_deployment.yml`
- `proj1_web_server_setup.yml`

**aws_ec2.yml**: This .yml file is dynamic hosts file that will list certain ec2 instances depending on the filters we define

**index.html**: This .html file is our personalized html page that we will serve on our private web servers

**proj1_main.yml**: Main .yml ansible file that imports the two following .yml ansible files

**proj1_service_deployment.yml**: This .yml ansible file adds our html file (via git) and restarts the apache2 web service 

**proj1_web_server_setup.yml**: This .yml ansible file installs apache2 web service and installs git

---

## **Prerequisites**

**Bastion Host and Private Servers**

**_NOTE: BOTH THE BASTION AND THE PRIVATE SERVERS ARE USING UBUNTU 18.04_**

Your select _bastion-host_ and your select _private-server(s)_ should be on the **SAME** VPC.

Your _bastion-host_ and your _private-server_ are tagged. Key=Name and Value=BastionHost/PrivateServer

Your _bastion-host_ should only be ssh-accessable by IPs that your organization trusts. 

Your _private-servers_ should only be ssh-accessable by the **_PUBLIC_** and **_PRIVATE_** IPs of your _bastion-host_.

Also your _private-servers_ should have connection to the internet as well. This can be through a nat gateway.

The .pem private key for both your _bastion-host_ and your _private-servers_ could be the same if you want. 

**Prepping Your Private Servers**

1. In a new terminal window,lets call this: **Terminal A**, SSH into your _bastion-host_
``` bash
$ ssh -i NAMEOFKEY.pem ubuntu@ip-of-bastion-host.pem
```

2. Open a new terminal window, lets call this: **Terminal B**

3. In **Terminal B** SCP the .pem private key file associated with your _private-servers_ into your _bastion-host_
``` bash
$ scp -i NAMEOFBASTIONHOSTKEY.pem /location/of/privateserverkey.pem ubuntu@ip-address-of-bastion-host:/home/ubuntu/
```

4. In **Terminal A**, confirm in that the privateserver .pem key file has transferred successfully into your _bastion-host_, specifically within the /home/ubuntu/ directory 
``` bash
$ cd /home/ubuntu ; ls -l | grep .pem
```

5. If it is there, in **Terminal A** ssh into your private server using the following command: 
``` bash
$ ssh -i location/of/private/server/key.pem ubuntu@ip-address-of-private-server
```

6. If successfull, now just simply update the private server: 
``` bash
$ sudo apt update ; exit
```

7. Repeat this process individually for **EACH** private server 

**_NOTE: Multiple Private-Servers can result in multiple bastion-hosts. This example works on a 1 bastion-host to 1:M private-servers scenario_**

---

## **Step 1: Prepping Our _Bastion-Host_**

Login into your _bastion-host_ in a new terminal window with the following command: 
``` bash
$ ssh -i /path/to/bastion-host/key.pem ubuntu@ip-address-of-bastion-host
```

Once logged in execute the following commands: 
``` bash
$ sudo apt update
$ sudo apt-add-repository ppa:ansible/ansible
$ sudo apt-get update -y
$ sudo apt-get install ansible -y
$ ansible --version
$ sudo apt install python-pip
$ sudo pip install botocore
$ sudo pip install boto3
$ sudo apt-get install git -y
```

After everything has finished, now traverse to your home directory: 
``` bash
cd /home/ubuntu/ 
```

Now git clone our [repo](https://github.com/Angelo512/Terabyte-CIT481-Senior-Project) into /home/ubuntu directory within your _bastion-host_: 
``` bash
$ git clone https://github.com/Angelo512/Terabyte-CIT481-Senior-Project.git
```

Once our repo is cloned, move the ansible folder into /home/ubuntu directory: 
``` bash
mv /home/ubuntu/Terabyte-CIT481-Senior-Project/Project1/Ansible /home/ubuntu/Ansible
```

Remember that _private-server_ key you copied into the /home/ubuntu directory of your _bastion-host_, now move it into the Ansible folder
``` bash 
mv private-server-key.pem /Ansible/private-server-key.pem
``` 

## **Step 2: Ansible.cfg And aws_ec2.yml**

Now we have to edit the ansible.cfg file: 
``` bash 
sudo nano /etc/ansible/ansible.cfg
```

Once here look through the file until you find the `[inventory]` section and add the following (if not already there): 
`[inventory]`
`enable_plugins = aws_ec2, host_list, script, auto, yaml, ini, toml`

<br> 

**_aws_ec2.yml_**

This file is the dynamic host list that we will use to dynamically list the ec2 instance we specify to list. For this file all that is needed to edit, `sudo nano`, is the `aws_access_key`, `aws_secret_key`, and the `regions`. 

Once that is done, run this command within your _bastion-host_ to list your ec2 instances: 
``` bash
$ ansible-inventory -i aws_ec2.yml --graph
``` 

Your output should look something like this: 
``` bash
@all:
  |--@aws_ec2:
  |  |--ec2-35-164-91-93.us-west-2.compute.amazonaws.com
  |  |--ec2-54-202-93-155.us-west-2.compute.amazonaws.com
  |  |--ec2-54-218-0-115.us-west-2.compute.amazonaws.com
  |  |--ip-172-31-26-159.us-west-2.compute.internal
  |  |--ip-172-31-5-192.us-west-2.compute.internal
  |--@tags_Name_BastionHost:
  |  |--ec2-54-202-93-155.us-west-2.compute.amazonaws.com
  |--@tags_Name_PrivateServer:
  |  |--ip-172-31-26-159.us-west-2.compute.internal
  |  |--ip-172-31-5-192.us-west-2.compute.internal
  |--@tags_Name_PublicServer:
  |  |--ec2-35-164-91-93.us-west-2.compute.amazonaws.com
  |  |--ec2-54-218-0-115.us-west-2.compute.amazonaws.com
  |--@ungrouped:
```


## **Step 3: Executing The Ansible Playbooks**

Now you can finally execute the ansible playbooks! 

**NOTE**: Execute this command in the same within your /home/ubuntu/Ansible directory. Here there should be the `proj1_web_server_setup.yml`, `proj1_service_deployment.yml`, `aws_ec2.yml`, and the `privateserverkeyfile.pem` 

Now execute the following command: 
``` bash
$ ansible-playbook -i aws_ec2.yml -l tags_Name_NAME proj1_main.yml -u ubuntu --key-file NAMEOFKEYFILE.pem
```

Replace NAME with the name of associated with your private-server group, look at the output of the `ansible-inventory -i aws_ec2.yml --graph` command 

Replace NAMEOFKEYFILE.pem with the name of the .pem key file that is tied to your _private-server_

## **Step 4: View The Results!**

Now access the website that is being served by your private servers! 

## **_Resources_**

[Ansible Dynamic Inventory](https://medium.com/awsblogs/ansible-dynamic-inventory-d7c1c57f0a93)

[Ansible Documentation](https://docs.ansible.com/ansible/latest/index.html)

[Lambda Functions](https://www.howtoforge.com/aws-lambda-function-to-start-and-stop-ec2-instance/)

---

## **Lambda Functions**

Two .py files are here: 
- `StartEC2Instance.py`
- `StopEC2Instance.py`

In short, these python files can be used as reference when creating the two lambda functions that start and stop your ec2 instances. 

**_NOTE_**

Make sure that you attach a role with the ec2fullaccess policy attached to it
