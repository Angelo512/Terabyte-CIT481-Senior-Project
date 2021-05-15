## **Using Ansible For Installing And Configuring Our Monitoring Solution: Prometheus And Grafana**

Inside This Folder: 
- `proj2_bastion_main.yml`
- `proj2_server_main.yml`
- `proj2_node_exporter.yml`
- `proj2_prometheus.yml`
- `proj2_grafana.yml`
- `aws_ec2.yml`

**proj2_bastion_main.yml**: This playbook imports all of the following playbooks: `proj2_node_exporter.yml`, `proj2_prometheus.yml`, and `proj2_grafana.yml`. Per namesake, this playbook **SHOULD ONLY** be ran on your bastion host.

**proj2_server_main.yml**: This playbook imports the `proj2_node_exporter.yml` playbook. This playbook **SHOULD ONLY** be ran on your private servers.

**proj2_node_exporter.yml**: This playbook installs and configures node exporter on your server.

**proj2_prometheus.yml**: This playbook installs and configures prometheus on your server.

**proj2_grafana.yml**: This playbook installs and configures grafana on your server.

**aws_ec2.yml**: This .yml file is dynamic hosts file that will list certain ec2 instances depending on the filters we define.


---

## **Prerequisites**

**Bastion Host And Private Servers**

Too proceed with installing our monitoring software you will need to do the following first: 

- [_Setting Up Your BastionHost-to-PrivateServer Environment_](https://github.com/Angelo512/Terabyte-CIT481-Senior-Project/blob/main/Project1/Ansible/README.md#prerequisites)

- [_Configuring Dynamic Ansible List On Your Bastion Host_](https://github.com/Angelo512/Terabyte-CIT481-Senior-Project/blob/main/Project1/Ansible/README.md#step-2-ansiblecfg-and-aws_ec2yml)

Next you will need to create two new security groups, each having their own rules: 

- **Prometheus** 
	- Type: TCP   Port: 9090   Custom:(Your IP or trusted IP Range)
	- Type: TCP   Port: 3000   Custom:(Your IP or trusted IP Range)
	- Type: TCP   Port: 9100   Custom:(Your IP or trusted IP Range)
- **Nodes**
	- Type: TCP   Port: 9100   Custom:(	IP ADDRESS (PUBLIC AND PRIVATE) OF YOUR BASTION HOST)
	- Type: TCP   Port: 9100   Custom:(Your IP or trusted IP Range)

What are these ports for you may ask: 
- Port `9090` - Prometheus
- Port `3000` - Grafana
- Port `9100` - Node_Exporter

---

## **Editing Our Ansible Playbooks**

If you followed the steps prior, you should have git clone over the Terabyte [Repo](https://github.com/Angelo512/Terabyte-CIT481-Senior-Project) to your bastion host, even so follow these steps:

`cd /`
`sudo git clone https://github.com/Angelo512/Terabyte-CIT481-Senior-Project.git`
`mv /Terabyte-CIT481-Senior-Project/Project2/Ansible /Monitoring`
_next move over your .pem key that you use to ssh into your private servers from within your bastion into the /Monitoring Directory_
`cd /Monitoring`

Inside this folder there should be these files: 
- `proj2_bastion_main.yml`
- `proj2_server_main.yml`
- `proj2_node_exporter.yml`
- `proj2_prometheus.yml`
- `proj2_grafana.yml`

Now we need to edit our `proj2_prometheus.yml` file to reach your private instances:

`cd /Monitoring/`
`sudo nano proj2_prometheus.yml`

From here you need to traverse to the tasks: `Adding Our Servers To Monitor To /etc/hosts File` and `Creating /etc/prometheus/prometheus.yml Configuration File`

Once here, there are commented sections in which it explains how to add our targets aka our private servers. **NOTE: For IP Addressess, put the private IP Addresses of your private servers**

Now we will need to edit the `aws_ec2.yml` file: 

You can follow these steps: [_Configuring Dynamic Ansible List On Your Bastion Host_](https://github.com/Angelo512/Terabyte-CIT481-Senior-Project/blob/main/Project1/Ansible/README.md#step-2-ansiblecfg-and-aws_ec2yml)

---

## **Running Our Ansible Playbooks**

**proj2_server_main.yml**

First `cd /Monitoring` and do `ls`

This should be your output: 
- `proj2_bastion_main.yml`
- `proj2_server_main.yml`
- `proj2_node_exporter.yml`
- `proj2_prometheus.yml`
- `proj2_grafana.yml`
- `README.md`
- `private-server-key.pem`

From within this directory execute the following command: 

`ansible-inventory -i aws_ec2.yml --graph`

From here record the tag names of your bastion host and your private servers (lets say for example: tags_Name_Bastion (Your bastion) and (Your private servers) tags_Name_PrivateServer)

Now lets execute monitoring installation on our private servers: 

`ansible-playbook -i aws_ec2.yml -l tags_Name_PrivateServer proj2_server_main.yml -u ubuntu --key-file NAMEOFKEYFILE.pem`

_note: replace your key file with the one that allows you to connect to your private servers via your bastion host through ssh_

Next, execute monitoring installation on our bastion host: 

`ansible-playbook -i aws_ec2.yml -l tags_Name_Bastion proj2_bastion_main.yml -u ubuntu --key-file NAMEOFKEYFILE.pem`

_note: replace your key file with the one that allows you to connect to your private servers via your bastion host through ssh_

Hopefully, everything should work just fine and now node_exporter, prometheus, and grafana should be installed on your bastion and your private servers!

---

## **Viewing Our Prometheus and Grafana**

For Prometheus: 
- On your browser, just copy and paste the public ip address of your bastion host and add :9090 to the end 

For Grafana: 
- On your browser, just copy and paste the public ip address of your bastion host and add :3000 to the end 

---

## **Adding Promethesus Data Source To Grafana**

Go to `http://bastion-ip-address:3000` 

Login with `Admin` and `Admin` (You can change it later)

Go to settings -> Choose Prometheus

Give your data source a name and for the url put `http://localhost:9090/`

Next test and save

Next import a dashboard

Click the `+` icon -> import 

Added the following website: `https://grafana.com/grafana/dashboards/1860`

Click load

Next add a name of your choice and save or launch it 

Now you will be able to see your new dashboard!

---

## **_Resources_**

[Getting Started with Prometheus and Grafana](https://medium.com/devops-dudes/install-prometheus-on-ubuntu-18-04-a51602c6256b)

[Monitoring using Prometheus and Grafana on AWS EC2](https://devops4solutions.com/monitoring-using-prometheus-and-grafana-on-aws-ec2/)

---
