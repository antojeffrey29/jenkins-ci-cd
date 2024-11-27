import os
import pymysql
import boto3

def handler(event, context):
    rds_host = os.environ['RDS_HOST']
    db_user = os.environ['RDS_USER']
    db_password = os.environ['RDS_PASSWORD']
    db_name = os.environ['RDS_DATABASE']
    sns_topic_arn = os.environ['SNS_TOPIC_ARN']
    
    conn = pymysql.connect(
        host=rds_host, user=db_user, passwd=db_password, db=db_name, connect_timeout=5
    )
    
    with conn.cursor() as cursor:
        # Example query to check if new data is added
        cursor.execute("SELECT COUNT(*) FROM my_table WHERE created_at > NOW() - INTERVAL 1 MINUTE")
        result = cursor.fetchone()
        
        if result[0] > 0:
            sns_client = boto3.client("sns")
            sns_client.publish(
                TopicArn=sns_topic_arn,
                Message="New data has been added to the RDS instance!",
                Subject="RDS Data Alert"
            )

    conn.close()
    return {"statusCode": 200, "body": "Check complete"}