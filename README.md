# Terabyte-CIT481-Senior-Project
This is team Terabyte's CIT481 Senior Project Repo

## **Project 0**

### - Setup AWS Virtual Private Cloud (VPC)
- Click on VPC from AWS Services menu
- Click Your VPCs on VPC Dashboard, Click Create VPC at top right
- Enter Name tag and IPv4 CIDR block info, No IPv6 CIDR block and default Tenancy
- Click Create VPC button at bottom
![CVPC](https://user-images.githubusercontent.com/70084203/112622949-f3f85780-8de8-11eb-8494-8d0b615da483.png)
- At VPC Dashboard Click Subnets, Create subnet at top right
- Select VPC from dropdown menu, enter subnet name, availability zone, IPv4 CIDR block
- Click Create subnet button at bottom, Repeat steps to configure 3 public and 3 private subnets in separate zones
![PRSUB](https://user-images.githubusercontent.com/70084203/112623825-1048c400-8dea-11eb-92aa-661b5e1efe74.png)
- Click Internet Gateways on VPC Dashboard, Create internet gateway at top right
- Enter Name Tag, Create Internet gateway at bottom
![CIG](https://user-images.githubusercontent.com/70084203/112624071-57cf5000-8dea-11eb-8f31-94869d4fa45d.png)
- Once created, click Actions at right and attach to internet gateway to VPC
![AGVPC](https://user-images.githubusercontent.com/70084203/112624251-9bc25500-8dea-11eb-9703-f64d282ef917.png)
- At VPC Dashboard, click Route Tables, Click Create route table
- Enter a Name Tag Public-routeTable, select VPC, Click Create, repeat same process to create Private-routeTable
- With Route Tables still selected in VPC Dashboard, select Public-route Table, click Edit routes
- Enter 0.0.0.0/0 for Destination, Select Internet Gateway as Target, Click Save Routes  (Add IGW to public route table)
![IGW](https://user-images.githubusercontent.com/70084203/112624792-4c305900-8deb-11eb-88bd-432a5b78adb3.png)
- With Public-route Table selected, Click Subnet Associations tab at bottom, Edit subnet associations, select 3 public subnets
- Select Private-route Table and repeat previous step to Edit subnet associations and select 3 private subnets
![STRT](https://user-images.githubusercontent.com/70084203/112624945-826dd880-8deb-11eb-89e9-65863a55426f.png)

### - Setup a Web Server on AWS Elastic Compute Cloud (EC2)
- Select Services from main AWS menu, then EC2, Click Instances in EC2 Dashboard then Launch Instances a top right
- Scroll down to select Ubuntu Server 18.04 LTS Amazon Machine Image, Select T2 Micro, Click Next
![US18](https://user-images.githubusercontent.com/70084203/112625169-c9f46480-8deb-11eb-9472-efe7c291e662.png)
- Configure Instance details, select non default VPC for network, choose a public subnet, Auto assign IP enabled
![CID](https://user-images.githubusercontent.com/70084203/112625350-045e0180-8dec-11eb-973d-68aae84a62ba.png)
- Click Next past storage and tags to Configure security group, allow SSH and HTTP, review, launch, choose key pair
![RAL](https://user-images.githubusercontent.com/70084203/112625506-42f3bc00-8dec-11eb-8ffd-530daae5647e.png)

- AWS Service Overview
![AWSs](https://user-images.githubusercontent.com/70084203/112683327-9f77cb00-8e2e-11eb-8437-09f52076149b.png)


### - Generate TLS Certificate
- Go to [Let's Encrypt](https://letsencrypt.org/)
  To enable HTTPS on your website, you need to get a certificate (a type of file) from a Certificate Authority (CA). Let’s Encrypt is a CA. In order to get a certificate for your website’s domain from Let’s Encrypt, you have to demonstrate control over the domain.   
- Use [ACEM protocol](https://tools.ietf.org/html/rfc8555)
- There are two ways to setup
  - With `Shell` - we choose this way
    - Use [Certbot](https://certbot.eff.org/) ACME client.
  - Without `Shell`

`Requirement to use Certbot`  
![Certbot](https://user-images.githubusercontent.com/69828773/110901905-e2c42c80-82b9-11eb-86cd-38a5e7f97234.png)  

Process of installation certification [Reference](https://certbot.eff.org/lets-encrypt/ubuntubionic-apache)  
1. Access server via SSH
2. Install snapd & Ensure the version of snapd is up to date  
  `$ sudo snap install core; sudo snap refresh core`
3. Install Certbot  
  `$ sudo snap install --classic certbot`
4. Prepare the Certbot command  
  `$ sudo ln -s /snap/bin/certbot /usr/bin/certbot`
5. Choose how you'd like to run Certbot
  - Either install a certificate (Cerbot edit Apache configuration automatically)  
  `$ sudo certbot --apache`
  - Or just get a Certificate (if you prefer to set up Apache configuration by hand)  
    `$ sudo certbot certonly --apache`  
6. Test automatic renewal  
  `$ sudo certbot renew --dry-run`  
7. Confirm the Certbot worked   
  Access `terabytecit.com` in browser and see if the security icon in the address bar. 
