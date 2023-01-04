# 05 Null Resource
It implements standard resource lifecycle but takes no furter action.

In general this is being used to intercept an changes in the resource and then perform action.

```code
resource "aws_instance" "cluster" {
  count = 3

  # ...
}

resource "null_resource" "cluster" {
    
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    cluster_instance_ids = join(",", aws_instance.cluster.*.id)
  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host = element(aws_instance.cluster.*.public_ip, 0)
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "join-cluster-svc.sh ${join(" ", aws_instance.cluster.*.private_ip)}",
    ]
  }
}
```