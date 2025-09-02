import boto3
import json

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('Visitors')

def lambda_handler(event, context):
    # Update visitor count
    response = table.update_item(
        Key={'id': 'counter'},
        UpdateExpression='SET visits = if_not_exists(visits, :start) + :inc',
        ExpressionAttributeValues={':inc': 1, ':start': 0},
        ReturnValues="UPDATED_NEW"
    )
    return {
        'statusCode': 200,
        'headers': {'Access-Control-Allow-Origin': '*'},
        'body': json.dumps({'visits': int(response['Attributes']['visits'])})
    }
