
### Team Blog on Github Pages!
[Terabyte Team Blog](https://angelo512.github.io/Terabyte-CIT481-Senior-Project/)

Project 2 Network Diagram
![Project2_vpc w_load balancer diagram](https://user-images.githubusercontent.com/69828773/118353341-a95aa800-b51a-11eb-9b20-29fba2137dd8.png) 

### Domain Setup
- Our domain `terabytecit.com` was transferred from NameCheap.com to AWS
- Create terraform file (terabyteR53.tf) to create a hosted zone and a record to let our domain `terabytecit.com` to point to load balancer DNS address (ie. terabyte-elb-**********.us-west-2.elb.amazonaws.com) 
- Generate TLS certificate in the servers [refer project0 README for instruction](https://github.com/Angelo512/Terabyte-CIT481-Senior-Project/blob/main/Project0/README.md#--generate-tls-certificate) 
