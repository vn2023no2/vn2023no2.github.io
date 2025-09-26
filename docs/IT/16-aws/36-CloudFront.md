---
sidebar_position: 36
---

# CloudFront

## Alarm
- Với những metric không hiển thị để chọn từ CloudWatch thì có thể:
    - Chọn từ monitoring dashboard => Alarm
    - Tạo bằng Terraform

- Chọn region cho Distribution của CloudFront là Global để đảm bảo hiển thị full metric
```
  dimensions = {
    ...
    DistributionId = "E1AWG4A6VKWH3G"
    Region         = "Global"
    ...
  }
```

- Ở phần dimensions KHÔNG THỂ dùng `ResourceArn`, phải dùng `DistributionId`
```
  dimensions = {
    ...
    ResourceArn = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${aws_cloudfront_distribution.tcb_stg_aem_cf_to_alb.id}" ## Do not use
    Region         = "Global"
    ...
  }
```