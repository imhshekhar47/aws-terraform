# List and Map


## List
```code
data "aws_availability_zones" "available" {
  state = "available"
}

output "list_of_az_name_1" {
    value = toset([ for z in data.aws_availability_zones: z.name ])
}

output "list_of_az_name_2" {
    value = toset([ for z in data.aws_availability_zones: z.name if startswith(z.name, "us-")])
}
```

## Map
```code
data "aws_availability_zones" "available" {
  state = "available"
}

output "map_of_az_name_1" {
    value = tomap({ for z in data.aws_availability_zones: z.name => z.id })
}

output "map_of_az_name_2" {
    value = tomap({ for k, v in data.aws_availability_zones: k => v.id  if startswith(z.name, "us-") })
}
```

#### keys function
keys(map)

```code
keys({ "a"=>1, "b"=2})
# [ "a", "b" ]
```

#### for_each function
for_each(map | list)
```code
for_each({"a" => 1, "b" => 2})
# each.key   => ["a", "b"]
# each.value => [ 1, 2]

for_each(["a", "b"])
# each.key   => ["a", "b"]
# each.value => ["a", "b"]
```