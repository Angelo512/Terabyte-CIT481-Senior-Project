# Terabyte-CIT481-Senior-Project
This is team Terabyte's CIT481 Senior Project Repo

## **Project 0**

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
  Access `terabytecit.com` in browser and see if the security icon in the address bar. 
7. Confirm the Certbot worked  
