resource "aws_docdb_cluster" "docdb" {
  cluster_identifier      = "roboshop-${var.ENV}"
  engine                  = "docdb"
  master_username         = "admin1"
  master_password         = "roboshop1"
  db_subnet_group_name    = aws_docdb_subnet_group.docdb.name
  vpc_security_group_ids = [aws_security_group.allows_docdb.id]
  skip_final_snapshot     = true
}


resource "aws_docdb_subnet_group" "docdb" {
  name       = "roboshop-docdb-${var.ENV}"
  subnet_ids =  data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_ID

  tags = {
    Name = "robot-docdb-${var.ENV}"
  }
}


# Creates the nodes needed for the created DOCDB Cluster
resource "aws_docdb_cluster_instance" "cluster_instances" {
  count              = 1
  identifier         = "roboshop-docdb-${var.ENV}"
  cluster_identifier = aws_docdb_cluster.docdb.id
  instance_class     = "db.t3.medium"
 }

