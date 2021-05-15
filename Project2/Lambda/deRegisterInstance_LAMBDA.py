import boto3
client = boto3.client('elbv2')
response = client.deregister_targets(
    TargetGroupArn='arn:aws:elasticloadbalancing:us-west-2:246397274220:targetgroup/testing/0fd957087164a9664',
    Targets=[
        {
            'Id': 'i-0d641d11c7ac618da',
        },
    ],
)

import time
time.sleep(120)

import boto3
client = boto3.client('ec2')
response = client.stop_instances(
    InstanceIDs=[
        'i-0d641d11c7ac618da',
    ]
)
