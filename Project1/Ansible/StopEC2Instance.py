import boto3
region = '' # Add the region where your resources are located
instances = [''] # Add the instance id(s) of the ec2 instance you are going to hit
ec2 = boto3.client('ec2', region_name=region)

def lambda_handler(event, context):
    ec2.stop_instances(InstanceIds=instances)
    print('stopped your instances: ' + str(instances))