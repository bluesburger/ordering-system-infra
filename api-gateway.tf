resource "aws_api_gateway_rest_api" "rest_api" {
  name = "${var.projectName}-api-gateway-rest-api"
  endpoint_configuration {
    types            = ["PRIVATE"]
    vpc_endpoint_ids = [data.aws_vpc_endpoint.vpc_endpoint.id]
  }
}

resource "aws_api_gateway_resource" "order_gateway_resource" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_rest_api.rest_api.root_resource_id
  path_part   = "order"
}

resource "aws_api_gateway_method" "apis_gateway_method" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.order_gateway_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "menu_integration" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.order_gateway_resource.id
  http_method = aws_api_gateway_method.apis_gateway_method.http_method
  type = "HTTP_PROXY"
  integration_http_method = "GET"
  uri                     = "http://${aws_lb.alb.dns_name}/api/order"
  credentials = aws_iam_role.orderingsystem_iam_role_for_ecs.arn
}

resource "aws_iam_role_policy" "ecs_role_policy" {
  name = "ecs_role_api_gateway_access"
  role = aws_iam_role.orderingsystem_iam_role_for_ecs.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "execute-api:Invoke"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:apigateway:${var.regionDefault}:${data.aws_caller_identity.current.account_id}:restapis/*"
      }
    ]
  })
}

resource "aws_api_gateway_rest_api_policy" "api_gateway_policy" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Principal = {
          "AWS": "*"
        }
        Action = [
          "execute-api:Invoke"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:apigateway:${var.regionDefault}:${data.aws_caller_identity.current.account_id}:restapis/*"
      }
    ]
  })
}

resource "aws_api_gateway_vpc_link" "vpc_link" {
  name        = "${var.projectName}-api-gateway-vpc-link"
  target_arns = [aws_lb.nlb.arn]
}
