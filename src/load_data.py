import boto3
import psycopg2
import os
from botocore.exceptions import ClientError

# Environment variables
RDS_ENDPOINT = os.getenv('RDS_ENDPOINT')
RDS_DB_NAME = os.getenv('RDS_DB_NAME')
RDS_USERNAME = os.getenv('RDS_USERNAME')
RDS_PASSWORD = os.getenv('RDS_PASSWORD')
DYNAMODB_TABLE_NAME = os.getenv('DYNAMODB_TABLE_NAME')

def handler(event, context):
    # Connect to RDS
    conn = psycopg2.connect(
        host=RDS_ENDPOINT,
        database=RDS_DB_NAME,
        user=RDS_USERNAME,
        password=RDS_PASSWORD
    )
    cursor = conn.cursor()
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table(DYNAMODB_TABLE_NAME)
    
    # Fetch data from RDS
    cursor.execute("SELECT emp_id, emp_name, emp_mail, salary FROM employees;")
    rows = cursor.fetchall()
    
    # Write to DynamoDB and send emails
    ses_client = boto3.client('ses')
    for row in rows:
        emp_id, emp_name, emp_mail, salary = row
        # Insert into DynamoDB
        table.put_item(
            Item={
                'emp_id': emp_id,
                'emp_name': emp_name,
                'salary': str(salary)
            }
        )
        
        # Send email
        try:
            ses_client.send_email(
                Source='your_email@example.com',
                Destination={'ToAddresses': [emp_mail]},
                Message={
                    'Subject': {'Data': 'Salary Credited'},
                    'Body': {'Text': {'Data': f"Dear {emp_name}, your salary of {salary} has been credited."}}
                }
            )
        except ClientError as e:
            print(f"Error sending email to {emp_mail}: {e}")
    
    cursor.close()
    conn.close()