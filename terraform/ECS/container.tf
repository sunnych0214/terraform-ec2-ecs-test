resource "aws_ecs_cluster" "cluster" {
  name = "${var.project_name}-cluster"
}

data "template_file" "template" {
  template = file("${path.module}/templates/template.json.tpl")
  
  vars = {
    app_image = var.app_image
    app_port = var.app_port
    aws_region = var.aws_region
    fargate_cpu = var.fargate_cpu
    fargate_memory = var.fargate_memory
  }
}

resource "aws_ecs_task_definition" "task_definition" {
  family = "${var.project_name}-family"
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  network_mode = "awsvpc"
  requires_compatibilities = [ "FARGATE" ]
  cpu = var.fargate_cpu
  memory = var.fargate_memory
  container_definitions = data.template_file.template.rendered
}

resource "aws_ecs_service" "service" {
  name = "${var.project_name}-service"
  cluster = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count = var.desired_count
  launch_type = "FARGATE"

  network_configuration {
    subnets = var.pri_subnet_ids
    security_groups = [ aws_security_group.ecs_tasks.id ]
  }
  load_balancer {
    target_group_arn = aws_alb_target_group.alb-tg.id
    container_name   = "test-app"
    container_port   = var.app_port
  }
}
