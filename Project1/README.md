## **Project 1**

### VPC with load balancer Diagram
![vpc w_load balancer diagram](https://user-images.githubusercontent.com/69828773/115308586-cb315c80-a11f-11eb-9532-7eba8b0ab082.png)

- Create Web server instances in private subnets
- Set NAT gateway in public subnet and create a route table to associate to private subnets
- Create a bastion host in public subet in order to access to instances in private subnet
- Set up Elastic load balancer to associate all availability zone

