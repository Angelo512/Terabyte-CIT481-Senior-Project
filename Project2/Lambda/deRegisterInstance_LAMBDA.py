import boto3
client = boto3.client('elbv2')
response = client.deregister_targets(
    TargetGroupArn='arn:aws:elasticloadbalancing:us-west-2:045970842620:targetgroup/testing/df625de58481ccc0',
    Targets=[
        {
            'Id': 'i-0d641d11c7ac618da',
        },
    ],
)

import time
time.sleep(310)

import boto3
client = boto3.client('ec2')
response = client.stop_instances(
    InstanceIDs=[
        'i-0d641d11c7ac618da',
    ]
)