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