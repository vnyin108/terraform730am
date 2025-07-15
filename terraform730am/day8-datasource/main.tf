resource "aws_iam_role" "lamda_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lamdapolicy" {
    role = aws_iam_role.lamda_role.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"

}

resource "aws_lambda_function" "my_lambda" {
    function_name = "my_lambdafunction"
    role          = aws_iam_role.lamda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime = "python3.13"
  timeout = 900
  memory_size = 128
    #filename         = "lambda_function.zip" 
    source_code_hash = filebase64sha256("lambda_function.zip")
    # ✅ Use S3 as the source
  s3_bucket         = aws_s3_object.lambda_zip.bucket
  s3_key            = aws_s3_object.lambda_zip.key
 

}
resource "aws_s3_object" "lambda_zip" {
  bucket = "lamdapackageupload123"
  key    = "lambda/lambda_function.zip"
  source = "lambda_function.zip"
  etag   = filemd5("lambda_function.zip")
}



  


  
