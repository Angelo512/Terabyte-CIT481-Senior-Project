import boto3
region = '' # Add the region where your resources are located 
instances = [''] # Add the instance id(s) of the ec2 instance you are going to hit
ec2 = boto3.client('ec2', region_name=region)

def lambda_handler(event, context):
    ec2.start_instances(InstanceIds=instances)
    print('started your instances: ' + str(instances))