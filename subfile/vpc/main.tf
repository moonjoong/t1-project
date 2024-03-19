resource "aws_vpc" "my_vpc" {
  cidr_block = var.cidr_vpc # VPC의 CIDR 블록을 지정합니다.

}

resource "aws_subnet" "my_subnet" {
  count             = length(var.cidr_sub)
  vpc_id            = aws_vpc.my_vpc.id         # 위에서 생성한 VPC의 ID를 사용합니다.
  cidr_block        = var.cidr_sub[count.index] # 서브넷의 CIDR 블록을 지정합니다.
  availability_zone = var.az                    # 사용할 가용 영역을 지정합니다. 원하는 가용 영역으로 변경하세요.

}



